Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318467AbSGaTXN>; Wed, 31 Jul 2002 15:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318468AbSGaTXN>; Wed, 31 Jul 2002 15:23:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:32267 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318467AbSGaTXM>; Wed, 31 Jul 2002 15:23:12 -0400
Date: Wed, 31 Jul 2002 20:26:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
Message-ID: <20020731202638.A22765@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <20020731131620.M15238@lustre.cfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020731131620.M15238@lustre.cfs>; from braam@clusterfs.com on Wed, Jul 31, 2002 at 01:16:20PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 01:16:20PM -0600, Peter J. Braam wrote:
> Hi, 
> 
> I've just been told that some "limitations" of the following kind will
> remain:
>   page index = unsigned long
>   ino_t      = unsigned long
> 
> Lustre has definitely been asked to support much larger files than
> 16TB.  Also file systems with a trillion files have been requested by
> one of our supporters (you don't want to know who, besides I've no
> idea how many bits go in a trillion, but it's more than 32).

What about using 64bit machines? ..


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbTEHE44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 00:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbTEHE44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 00:56:56 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:3858 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261172AbTEHE4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 00:56:55 -0400
Date: Thu, 8 May 2003 06:09:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make <linux/blk.h> obsolete
Message-ID: <20030508060930.B24325@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780C8FE1DC@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C8FE1DC@orsmsx116.jf.intel.com>; from inaky.perez-gonzalez@intel.com on Wed, May 07, 2003 at 07:57:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 07:57:16PM -0700, Perez-Gonzalez, Inaky wrote:
> > +/* this file is obsolete, please use <linux/blkdev.h> instead */
> 
> #warning this file is obsolete, please use <linux/blkdev.h> instead
> 
> At least is kind of more noisy and easy to spot when compiling ...

See the postings earlier in this thread.  There's currently too many
users around in the tree (but Adrian has a patch he'll hopefully
submit soon)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSIDVcU>; Wed, 4 Sep 2002 17:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSIDVcU>; Wed, 4 Sep 2002 17:32:20 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:62993 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315690AbSIDVcT>; Wed, 4 Sep 2002 17:32:19 -0400
Date: Wed, 4 Sep 2002 22:36:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem on a kernel driver(SuSE, SMP)
Message-ID: <20020904223653.A12044@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Libershteyn, Vladimir" <vladimir.libershteyn@hp.com>,
	linux-kernel@vger.kernel.org
References: <8C18139EDEBC274AAD8F2671105F0E8E012704D7@cacexc02.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8C18139EDEBC274AAD8F2671105F0E8E012704D7@cacexc02.americas.cpqcorp.net>; from vladimir.libershteyn@hp.com on Wed, Sep 04, 2002 at 10:56:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 10:56:00AM -0700, Libershteyn, Vladimir wrote:
> Hi, Cristoph
> Attached are two related functions,
> I don't know if I can attach the files to the message,
> but I can place them in a message body.
> Please, let me know

Except of your failure to handle the return value of down_interruptible
I can't find any obvious bugs.  Does it work on plain 2.4.7 or redhats
2.4.7 rpm?  If so I'd fill a bug report against suses patch collection.


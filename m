Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWAaHpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWAaHpK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 02:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWAaHpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 02:45:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965055AbWAaHpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 02:45:08 -0500
Date: Mon, 30 Jan 2006 23:44:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.15.2
Message-Id: <20060130234443.78d06f5d.akpm@osdl.org>
In-Reply-To: <20060131073845.GA26024@suse.de>
References: <20060131070642.GA25015@kroah.com>
	<20060130233427.5e7912ae.akpm@osdl.org>
	<20060131073845.GA26024@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
> On Mon, Jan 30, 2006 at 11:34:27PM -0800, Andrew Morton wrote:
> > Greg KH <gregkh@suse.de> wrote:
> > >
> > > We (the -stable team) are announcing the release of the 2.6.15.2 kernel.
> > >
> > 
> > There remain some box-killing bugs:
> > 
> > - The scsi_cmd leak
> 
> In my to-apply queue, came after we started the review cycle here.

I wish it was in mine - I didn't know we had a fix.
 
> > - The BIO-uses-ZONE_DMA-hence-oom-killing bug
> > 
> > - A skbuff_head_cache leak causes oom-killings.
> 
> No one has forwarded these to us (stable@kernel.org), can someone please
> do so?

These remain unfixed, afaik.

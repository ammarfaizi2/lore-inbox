Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWAaRoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWAaRoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWAaRoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:44:05 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7628 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751167AbWAaRoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:44:04 -0500
Date: Tue, 31 Jan 2006 09:43:58 -0800
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.15.2
Message-ID: <20060131174358.GA9036@suse.de>
References: <20060131070642.GA25015@kroah.com> <20060130233427.5e7912ae.akpm@osdl.org> <20060131073845.GA26024@suse.de> <20060130234443.78d06f5d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130234443.78d06f5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 11:44:43PM -0800, Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> >
> > On Mon, Jan 30, 2006 at 11:34:27PM -0800, Andrew Morton wrote:
> > > Greg KH <gregkh@suse.de> wrote:
> > > >
> > > > We (the -stable team) are announcing the release of the 2.6.15.2 kernel.
> > > >
> > > 
> > > There remain some box-killing bugs:
> > > 
> > > - The scsi_cmd leak
> > 
> > In my to-apply queue, came after we started the review cycle here.
> 
> I wish it was in mine - I didn't know we had a fix.

I just bounced it to you, Jens found it in the scsi layer.

> > > - The BIO-uses-ZONE_DMA-hence-oom-killing bug
> > > 
> > > - A skbuff_head_cache leak causes oom-killings.
> > 
> > No one has forwarded these to us (stable@kernel.org), can someone please
> > do so?
> 
> These remain unfixed, afaik.

Oh :(

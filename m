Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbULUUIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbULUUIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbULUUHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:07:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:14308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261624AbULUT6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:58:02 -0500
Date: Tue, 21 Dec 2004 11:57:49 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041221195749.GA9505@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz> <20041217220208.GA22752@kroah.com> <20041217233915.GB29084@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217233915.GB29084@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2004 at 12:39:15AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > Okay, here it is, slightly expanded version. It actually makes use of
> > > newly defined type for type-checking purposes; still no code changes.
> > 
> > Alright, I've applied this, and it will show up in the next -mm release.
> > I also fixed up pci.h for when CONFIG_PCI=N due to your changed
> > functions.
> 
> Thanks... Hopefully I guessed the change right, otherwise this will
> need to be applied by hand.

You guessed right :)

> This adds missing prototype for pci_choose_state.								
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Applied, thanks.

greg k-h

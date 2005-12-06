Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVLFTRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVLFTRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbVLFTRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:17:20 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52369
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030192AbVLFTRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:17:19 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Luke-Jr <luke-jr@utopios.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Tue, 6 Dec 2005 13:17:11 -0600
User-Agent: KMail/1.8
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
References: <20051203152339.GK31395@stusta.de> <200512051834.01384.rob@landley.net> <200512061034.21336.luke-jr@utopios.org>
In-Reply-To: <200512061034.21336.luke-jr@utopios.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512061317.11592.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 04:34, Luke-Jr wrote:
> > > Nope, but I don't see how udev can possibly detect something that
> > > doesn't let the OS know it's there-- except, of course, loading the
> > > driver for it and seeing if it works.
> >
> > Stuff shows up in /sys whether or not Linux has a driver loaded for it.
>
> Only if Linux is aware it exists. I'm thinking of those old ISA cards and
> such.

A) This is only true for obsolete hardware.  Can you name an example that's 
currently being manufactured?  (I'm trying to figure out if serial mice 
count, not that you really need kernel support to detect those.)

B) You can insmod the module from userspace to actively probe for stuff.  If 
the kernel doesn't know either until it probes, and you can trigger the probe 
at will, what additional kernel support do you need?

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268805AbUHLVRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268805AbUHLVRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUHLVNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:13:48 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:45448 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S268795AbUHLVKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:10:22 -0400
Date: Thu, 12 Aug 2004 23:10:19 +0200
From: Martin Mares <mj@ucw.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Tim Wright <timw@splhi.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040812211019.GC2351@ucw.cz>
References: <1091899593.20043.14.camel@kryten.internal.splhi.com> <411BDD11.8070400@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411BDD11.8070400@tmr.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> But they *don't* map to consistent device names. All hot pluggable 
> devices seem to map to the next available name. Looking at one of my 
> utility systems, it has IDE drives mapped by Redhat with ide-scsi, real 
> SCSI drives, a couple of flash card slots mapped to SCSI, and a USB 
> device, all in the /dev/sdX namespace. And in the order in which they 
> were detected (connected, in other words).
> 
> Joerg hasn't made it any better, but it isn't great anyway. I recommend 
> a script to do discovery and make symlinks somewhere to names which 
> always match the same device.

Exactly. But although this is very easy with addressing by names in /dev
(just make the symlink), I do not see any sane solution in Joerg's world.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
If at first you don't succeed, redefine success.

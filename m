Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWAZNlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWAZNlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAZNlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:41:17 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:14291 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751333AbWAZNlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:41:17 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 14:39:52 +0100
To: nix@esperi.org.uk, matthias.andree@gmx.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       grundig@teleline.es, axboe@suse.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D128.nailE2X11K6WU@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
 <878xt3rfjc.fsf@amaterasu.srvr.nix>
In-Reply-To: <878xt3rfjc.fsf@amaterasu.srvr.nix>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix <nix@esperi.org.uk> wrote:

> Applications (already) do this by asking HAL, which can be informed of
> new devices in a variety of ways: the up-and-coming one is for the
> kernel to notify udevd, following which a udev rule sends a dbus message
> to HAL. Everything from the dbus message on up is cross-OS portable.
> -scanbus is *totally* unnecessary.

Interesting theory.... unfortunately this makes assumptions that cannot be 
proved. Where is this HAL available and more impportant: how is it related
to generis transport and device independent SCSI?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

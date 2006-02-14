Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030571AbWBNL2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbWBNL2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbWBNL2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:28:44 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:47821 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030571AbWBNL2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:28:44 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 14 Feb 2006 12:27:18 +0100
To: schilling@fokus.fraunhofer.de, nix@esperi.org.uk
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, davidsen@tmr.com,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F1BE96.nailMY212M61V@burner>
References: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
 <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
 <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner>
 <871wy6sy7y.fsf@hades.wkstn.nix>
In-Reply-To: <871wy6sy7y.fsf@hades.wkstn.nix>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix <nix@esperi.org.uk> wrote:

> > Do you really whant libscg to open _every_ non-directory file under /sys?
>
> Well, that would be overkill, but iterating across, say,
> /sys/class/scsi_device seems like it would be a good idea.
>
> (I doubt libscg would ever be interested in the stuff in most of the
> other directories: things like /dev/mem are not SCSI devices and never
> will be, and /sys/class/scsi_device contains *everything* Linux
> considers a SCSI device, no matter what transport it is on, SATA and
> all. However, I don't know if it handles IDE devices that you can SG_IO
> to because I don't have any such here. Anyone know?)

This statement is obviously not true :-(

Let us start in a way that makes sense:

Please send me the whitepaper that was used to define the interfaces
and functionality of the /sys device

Please send me the other documentation (e.g. man pages) on the /sys
device

Please send me a statement on how long this interface will be maintained
inside Linux without breaking interfaces.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

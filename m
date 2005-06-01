Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVFAQBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVFAQBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFAP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:58:07 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:21490 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261447AbVFAP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:57:35 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Jun 2005 17:56:20 +0200
To: lsorense@csclub.uwaterloo.ca, kraxel@suse.de
Cc: toon@hout.vanvergehaald.nl, schilling@fokus.fraunhofer.de,
       mrmacman_g4@mac.com, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429DDAA4.nail7BFB1SXEV@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org>
 <20050531190556.GK23621@csclub.uwaterloo.ca>
 <20050531195603.GB28168@bytesex>
In-Reply-To: <20050531195603.GB28168@bytesex>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr <kraxel@suse.de> wrote:

> > I don't know if the ide or scsi method is currently more sane, but it
> > sure would be nice to have a consistent behaviour between the two.
>
> On my suse 9.3, out-of-the-box, I find this (implemented via
> udev rules):
>
>    # find /dev/cd /dev/disk -type l -print | sort
>    /dev/cd/by-id/HL-DT-ST_DVDRAM_GSA-4040B_K213BDG5213
>    /dev/cd/by-id/LG_CD-RW_CED-8080B_2000_07_27e
>    /dev/cd/by-path/pci-0000:00:04.1-ide-1:0
>    /dev/cd/by-path/pci-0000:00:04.1-ide-1:1
>    /dev/disk/by-id/IBM-DTLA-305040_YJEYJM36751
>    /dev/disk/by-id/IBM-DTLA-305040_YJEYJM36751p1

Nice, but will be the Linux /dev/ fashion next year?

>From my experiences it makes no sense to implement support
for things like this before waiting long enough to know 
whether this is something that will become ordinary.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

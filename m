Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWAZOHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWAZOHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWAZOHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:07:22 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:36333 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932315AbWAZOHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:07:21 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 15:05:42 +0100
To: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de
Cc: rlrevell@joe-job.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D736.nailE2XB11W3N@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <C3FAC4ED-D7B6-45FE-BCC8-DDCE1E8EEC65@mac.com>
 <43D89F23.nailDTH5ZT0IY@burner>
 <20060126104012.GA32206@merlin.emma.line.org>
In-Reply-To: <20060126104012.GA32206@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Joerg Schilling schrieb am 2006-01-26:
>
> > Even with /dev/scg* on Solaris or with CAM on FreeBSD, you open a device.
> > But this is not a /dev/ entry for a high level device like a disk, it is 
> > a SCSI nexus device that allows you to send SCSI commands on any SCSI
> > transport.
>
> As long as the device you open allows you to send SCSI commands on any
> suitable (not just SCSI) transport, why bother?

If you open e.g. /dev/cam or /dev/scg?, you open device that is not related
to a high level service like /dev/hd* and this unfortunately is unable to talk 
to other devices in the same entity (e.g. ATAPI tapes).

With /dev/cam or similar you get a single handle for a group of devices that 
than are addressed via something very similar to dev=b,t,l

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

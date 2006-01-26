Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWAZKIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWAZKIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWAZKIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:08:23 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:43487 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932272AbWAZKIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:08:22 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 11:06:27 +0100
To: schilling@fokus.fraunhofer.de, mrmacman_g4@mac.com
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D89F23.nailDTH5ZT0IY@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <C3FAC4ED-D7B6-45FE-BCC8-DDCE1E8EEC65@mac.com>
In-Reply-To: <C3FAC4ED-D7B6-45FE-BCC8-DDCE1E8EEC65@mac.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:

> On Jan 25, 2006, at 12:14:15, Joerg Schilling wrote:
> > Incorrect, sorry. Do you really make Linux incompatible to the rest  
> > of the world?
..
> >> 1 platform (Linux) _requires_ /dev/* access
> > Your last line is wrong
>
> No, it is correct.  We require /dev/* access.  The fact that we  
> included /dev/sg* devices for /dev/[sh]d* was a mistake, and should  
> be fixed, but those are still /dev/* access.

Looks like you missunderstood /dev/* here.

Even with /dev/scg* on Solaris or with CAM on FreeBSD, you open a device.
But this is not a /dev/ entry for a high level device like a disk, it is 
a SCSI nexus device that allows you to send SCSI commands on any SCSI transport.




Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

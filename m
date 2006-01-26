Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWAZSmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWAZSmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWAZSmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:42:42 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36560 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751360AbWAZSml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:42:41 -0500
Date: Thu, 26 Jan 2006 19:42:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: acahalan@gmail.com, rlrevell@joe-job.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43D8D396.nailE2X31OHFU@burner>
Message-ID: <Pine.LNX.4.61.0601261941410.14581@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner> <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com>
 <43D8D396.nailE2X31OHFU@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>IRIX is not on this list because it uses the same kind of interface as
>e.g. HP-UX does
>
>	snprintf(devname, sizeof (devname),
>			"/dev/scsi/sc%dd%dl%d", busno, tgt, tlun);

So, would you want something like (free format string imagination)
   "/dev/sg-%d-%d-%d", busno, tgt, lun
on Linux?


Jan Engelhardt
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWAYREO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWAYREO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 12:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWAYREO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 12:04:14 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:47305 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932072AbWAYREN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 12:04:13 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 25 Jan 2006 18:03:18 +0100
To: jengelh@linux01.gwdg.de, axboe@suse.de
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D7AF56.nailDFJ882IWI@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de>
In-Reply-To: <20060125153057.GG4212@suse.de>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:

> You just want the device naming to reflect that. The user should not
> need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
> likely be using k3b or something graphical though, and just click on his
> Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
> help do this dynamically even.

Guess why cdrecord -scanbus is needed.

It serves the need of GUI programs for cdrercord and allows them to retrieve 
and list possible drives of interest in a platform independent way.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

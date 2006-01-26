Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWAZN5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWAZN5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWAZN5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:57:30 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:10978 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932312AbWAZN53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:57:29 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 14:56:29 +0100
To: matthias.andree@gmx.de, grundig@teleline.es
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, axboe@suse.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D50D.nailE2X5WK8ZO@burner>
References: <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
 <20060125182552.GB4212@suse.de>
 <20060125231422.GB2137@merlin.emma.line.org>
 <20060126020951.14ebc188.grundig@teleline.es>
 <20060126082324.GB13125@merlin.emma.line.org>
In-Reply-To: <20060126082324.GB13125@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Well, you need to implement 30 (or so) platform-specific ways to get a
> list of devices, and portable applications aren't going to do that. To
> make it explicit: no way. It is a maintenance nightmare, 30 lowly-tested
> pieces of code, too.

It already works in libscg since nearly 10 years.

> This sounds like a huge difference, but I don't believe it actually is.
> Jörg is trying to fight the system rather than stop complaining to users
> about their using /dev/hd*. The scanning code is there and can be made
> working with little effort probably.

Talking about /dev/hd* ignore the basic problem. Show me a way how to
send SCSI commands to a ATAPI tape drive on Linux. 

Please do not forget that libscg is OS _and_ device independent.
Implementing /dev/hd* support at all is already a concession that did go to far.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

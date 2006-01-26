Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWAZNnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWAZNnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWAZNnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:43:07 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:22740 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751340AbWAZNnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:43:05 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 14:41:52 +0100
To: matthias.andree@gmx.de, grundig@teleline.es
Cc: schilling@fokus.fraunhofer.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de, axboe@suse.de,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D1A0.nailE2X2510V9@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
 <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
 <20060125182552.GB4212@suse.de>
 <20060125231422.GB2137@merlin.emma.line.org>
 <20060126020951.14ebc188.grundig@teleline.es>
In-Reply-To: <20060126020951.14ebc188.grundig@teleline.es>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<grundig@teleline.es> wrote:

> It's too "much effort"? Basically, what linux is asking is that cdrecord
> stop wasting efforts trying to implement its own solution. Linux is 
> asking cdrecord to use SG_IO and leave device discovery and data transport
> issues to the platform.

Cddrecord does not use SG_IO, cdrecord uses the platform independent libscg.

If you like to talk on cdrecord, you are talking about the wrong thing.

libscg is the target of interest.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

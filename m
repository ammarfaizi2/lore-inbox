Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282143AbRK1MUG>; Wed, 28 Nov 2001 07:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282131AbRK1MT7>; Wed, 28 Nov 2001 07:19:59 -0500
Received: from MAILGW01.bang-olufsen.dk ([193.89.221.116]:29961 "EHLO
	mailgw01.bang-olufsen.dk") by vger.kernel.org with ESMTP
	id <S282143AbRK1MTl>; Wed, 28 Nov 2001 07:19:41 -0500
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ieee1394
In-Reply-To: <20011128103256.A28083@pcmaftoul.esrf.fr>
From: Kristian Hogsberg <hogsberg@users.sourceforge.net>
Date: 28 Nov 2001 13:19:25 +0100
In-Reply-To: <20011128103256.A28083@pcmaftoul.esrf.fr>
Message-ID: <m3herfrstu.fsf@dk20037170.bang-olufsen.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on BeoSmtp/Bang & Olufsen/DK(Release 5.0.6a |January
 17, 2001) at 28-11-2001 13:19:37,
	Serialize by Router on dzln11/Bang & Olufsen/DK(Release 5.0.6 |December 14, 2000) at
 28-11-2001 13:19:31,
	Serialize complete at 28-11-2001 13:19:31
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Maftoul <maftoul@esrf.fr> writes:

> Hello everyone,
>         Still me with my ieee1394 problems :)
> 
> Workaround: My goal is to make ieee1394 HardDisk  work in a production 
> environment:
> 	User come on a machine, plug his disk, store his (experience 
> 	results) datas on it, unplugs it and go away with it in his home
> 	institute where he processes his datas.

You should update to the latest cvs version, as it has some fixes for
sbp2 plug/unplug issues that hasn't yet made it into 2.4.  Move your
drivers/ieee1394 directory out of the way and then checkout the cvs
drivers as described here:

        http://linux1394.sourceforge.net/cvs.html

Kristian


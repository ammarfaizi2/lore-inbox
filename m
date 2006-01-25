Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWAYXO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWAYXO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWAYXO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:14:28 -0500
Received: from mail.gmx.net ([213.165.64.21]:56721 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932211AbWAYXO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:14:27 -0500
X-Authenticated: #428038
Date: Thu, 26 Jan 2006 00:14:22 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: Matthias Andree <matthias.andree@gmx.de>, grundig@teleline.es,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125231422.GB2137@merlin.emma.line.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>, grundig@teleline.es,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org,
	acahalan@gmail.com
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <20060125182552.GB4212@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125182552.GB4212@suse.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(stripped Lee from the Cc: list)

Jens Axboe schrieb am 2006-01-25:

> > Hm. sysfs, procfs, udev, hotplug, netlink (for IPv6) - this all looks rather
> > complicated and non-portable. I understand that applications that can just
> > open every device and send SCSI INQUIRY might want to do that on Linux, too.
> 
> Certainly, I'm just suggesting a better way to do it on Linux.

Great. There's a better way, but it is not necessary. Let Linux-specific
applications use it for their benefit, but a portable application isn't
going that way because it's too much effort. If a simpler interface that
can be shared with half a dozen other system exists, the portable
application will use that and ignore better interfaces.

-- 
Matthias Andree

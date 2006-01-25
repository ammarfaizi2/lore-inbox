Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWAYXUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWAYXUF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 18:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWAYXUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 18:20:04 -0500
Received: from mail.gmx.de ([213.165.64.21]:47784 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932215AbWAYXUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 18:20:03 -0500
X-Authenticated: #428038
Date: Thu, 26 Jan 2006 00:19:57 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: matthias.andree@gmx.de, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060125231957.GC2137@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
	jengelh@linux01.gwdg.de, axboe@suse.de
References: <1138048255.21481.15.camel@mindpipe> <20060123212119.GI1820@merlin.emma.line.org> <Pine.LNX.4.61.0601241823390.28682@yvahk01.tjqt.qr> <43D78585.nailD7855YVBX@burner> <20060125142155.GW4212@suse.de> <Pine.LNX.4.61.0601251544400.31234@yvahk01.tjqt.qr> <20060125145544.GA4212@suse.de> <43D7AEBF.nailDFJ7263OE@burner> <43D7B100.7040706@gmx.de> <43D7B345.nailDFJB1WWYF@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D7B345.nailDFJB1WWYF@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-25:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > I think we'd better call the whole discussion off.
> 
> We could continue as long as people like Jens Axboe stay reasonable.

No. The deal was people stating their requirements, not mounting
personal attacks against others. I posted the same question (what's
lacking) several times, and your constant answer "device enumeration"
makes me assume that it's the only thing you believe is missing.

Since libscg scans all /dev/pg* and /dev/sg* (for transport indicator ""
which means plain sg) and all /dev/hd* (for transport indicator ATA:
which means /dev/hd*) and turns it into bus, host, lun anyways, there
does not appear to be a need to move this code into the kernel.

What *else* is missing?

-- 
Matthias Andree

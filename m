Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265620AbUBJUbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 15:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266039AbUBJUbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 15:31:37 -0500
Received: from smtp.mailix.net ([216.148.213.132]:60284 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S265620AbUBJUbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 15:31:35 -0500
Date: Tue, 10 Feb 2004 21:31:26 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jaroslav Kysela <perex@suse.cz>
Message-ID: <20040210203126.GA1305@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	alsa-devel@lists.sourceforge.net,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jaroslav Kysela <perex@suse.cz>
References: <20040209214622.GA1944@steel.home> <s5h3c9j2tly.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <s5h3c9j2tly.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.5.1i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: Re: 2.6.3-rc1: intel8x0 broken
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.142.152.191 listed in dnsbl.njabl.org]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.142.152.191 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.142.152.191 listed in dnsbl.sorbs.net]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.142.152.191 listed in dnsbl.njabl.org]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1AqeW0-0005ED-NY)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai, Tue, Feb 10, 2004 10:04:25 +0100:
> > I have a Gigabyte GA-I8IPE1000 Pro motherboard with a built-in 82801EB
> > (Intel Corp. 82801EB AC'97 Audio Controller).
> > 
> > The thing stopped produce any sound since Linus' last alsa update.
> > Reverting to the previous state of alsa driver works, of course.
> 
> if your ac97 chip is ALC650 or ALC655/658, the attached patch should
> fix.
> 

ALC658. It did help, of course. Thank you very much.



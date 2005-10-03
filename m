Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVJCEan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVJCEan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVJCEam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:30:42 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:48008 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S932148AbVJCEam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:30:42 -0400
Date: Mon, 3 Oct 2005 01:30:37 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: 7eggert@gmx.de
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051003043037.GB5576@ime.usp.br>
Mail-Followup-To: 7eggert@gmx.de,
	Nigel Cunningham <ncunningham@cyclades.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4RlFC-2ev-17@gated-at.bofh.it> <4Rxdq-2Tc-19@gated-at.bofh.it> <4SXfs-7hM-27@gated-at.bofh.it> <E1ELufB-0001IH-TL@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1ELufB-0001IH-TL@be1.lrz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02 2005, Bodo Eggert wrote:
> Rogério Brito <rbrito@ime.usp.br> wrote:
> > I removed what was extracted right away and tried again to extract
> > the tree (at this point, suspecting even that something in software
> > had problems). The problem with bzip2 occurred again. Then, I
> > rebooted the system an the problem magically went away.
> 
> I have a similar problem:

I am still investigating the problem. I am not planning on resting right
now. I really want to understand what's going on with this system.

Too bad that I am quite naïve and don't understand much about hardware
in general. :-(

> This happens mostly if there are concurrent DMA transfers like playing
> sound or watching TV on bttv cards. I'm affected by the later cause,
> setting no_overlay reduced it.

Humm, I think that I may have seen something like this in the past: I
have two CD readers here (both with DMA turned on) and I was once
extracting audio to be converted to MP3 and I noticed one strange
corruption that I have not been able to reproduce again:

Bits of what was extracted from one file appeared in the other disc and
the result was something like a mix of static and alternation between
the two music sources. Weird, huh?


Thanks for the concern, Rogério Brito.

P.S.: I will reboot my system and force an fsck as soon as I can, just
in case.
-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTIGPLH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 11:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbTIGPLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 11:11:06 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:58892 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S263298AbTIGPLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 11:11:03 -0400
Path: Home.Lunix!not-for-mail
Subject: Re: Sensors and linux 2.6.0-test4-bk8 question
Date: Sun, 7 Sep 2003 15:09:58 +0000 (UTC)
Organization: lunix confusion services
References: <1062934034.7923.2.camel@rousalka.dyndns.org>
NNTP-Posting-Host: ns.home.lunix
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1062947398 20595 10.0.0.20 (7 Sep 2003 15:09:58
    GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sun, 7 Sep 2003 15:09:58 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:264709
X-Mailer: Perl5 Mail::Internet v1.51
Message-Id: <bjfho6$k3j$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1062934034.7923.2.camel@rousalka.dyndns.org>,
	Nicolas Mailhot <Nicolas.Mailhot@laPoste.net> writes:
> --=-scQmpSv1XJXK2Qdu4l48
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> 
> Hi,
> 
> Please bear with me and enlighten me a bit. I've been fiddling with
> 2.5/2.6 for some time, and got most of my hardware working (including
> acpi...) better than in 2.4. (in fact now I'm using only 2.6). So now I
> got to the point where I'm looking at nice-to-have stuff like sensors.
> 
> I know libsensors is not yet 2.6 aware, but I thought sensed values
> where available in sysfs if one wanted to manually read them. Since I
> have via hardware:

If there is any interest, I have a perl program that does a configurable 
display for 2.6

> 
> Now there is no sensor-related message as far as I can see in my dmesg,
> and I do not seem to find any temperature/fan related info in /sys:
> 

You still need the bus and chip drivers before anything appears.
Which ones is basically the same as with the old lmsensors stuff, so
look in their docs.

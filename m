Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268384AbTAMWd3>; Mon, 13 Jan 2003 17:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268382AbTAMWba>; Mon, 13 Jan 2003 17:31:30 -0500
Received: from mail.mediaways.net ([193.189.224.113]:36758 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268380AbTAMWbO>; Mon, 13 Jan 2003 17:31:14 -0500
Subject: Bug report : i810_audio, compaq evo 410c, 2.4.20
From: Soeren Sonnenburg <kernel@nn7.de>
To: Nicolas.Turro@sophia.inria.fr
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1042497413.1223.21.camel@sun>
Mime-Version: 1.0
Date: 13 Jan 2003 23:36:53 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I have laptops here (compaq evo 410c) that freeze completely while playing 
> sound (using mpg123, for example). The crash is random, it may freeze as soon
> as playback start of after a few minutes.

All I can say is me too... It seems as if the sound card is doing irq sharing and
strongly dislikes that... at least for me sound works for some seconds
then starts to stutter and crashes somewhen (within 30sec) later.

I was using kernel 2.4.18 (from debian woody).

I also tried alsa but some behaviour.

I saw that someone said he got it working, see:
 http://larve.net/people/hugo/2002/12/evo410

But I could not find out how.

It would be pretty nice if APM / ACPI worked for the evo ... did you
try it yet ?

Soeren.


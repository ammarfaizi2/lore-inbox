Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUAOU3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbUAOU3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:29:08 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:10150 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262705AbUAOU3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:29:05 -0500
Message-ID: <4006F88B.7010108@t-online.de>
Date: Thu, 15 Jan 2004 21:31:07 +0100
From: detlef.grittner@t-online.de (Detlef Grittner)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de-AT; rv:1.4) Gecko/20030821
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sound drop outs with 2.6.1 and via82xx
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: b7rdyBZlZeE4mOQ2qmWR0egEpWXiORej36q7m6kT8KIfomxbeI1Irl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have installed the 2.6.1 kernel on an AMD 64 (x86_64) and have an 
integrated onboard sound chip VIA VT8237.
The problem is, that the sound sometimes drops out or is distorted.
Drop outs appear reproducible when I minimize and maximize a Window in 
KDE on X11. (I've tried both the nvidia module and the X11 nv driver).
Additionally I get the message "linux kernel: ALSA via82xx.c:704: 
invalid via82xx_cur_ptr, using last valid pointer". But I'm not sure if 
this is connected with my problem, because when I boot the 2.4.21 kernel 
on the same machine I get the same error message in line 696, but I 
don't experience drop outs of the sound.
I use the default configuration of the via82xx module in both cases, 
that is no options in modprobe.conf or modules.conf.

Besides the lost pointer, does the problem come from the via82xx module 
at all?
Can someone help me in this matter?


Detlef


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSALSvm>; Sat, 12 Jan 2002 13:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287310AbSALSvc>; Sat, 12 Jan 2002 13:51:32 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:42511 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S287307AbSALSvW>; Sat, 12 Jan 2002 13:51:22 -0500
Message-ID: <3C40854E.3EF132F3@kolumbus.fi>
Date: Sat, 12 Jan 2002 20:49:50 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Writeout in recent kernels/VMs poor compared to last -ac
In-Reply-To: <009e01c19b7c$463457d0$02c8a8c0@kroptech.com> <20020112173018.Q1482@inspiron.school.suse.de> <00fd01c19b95$b3ec3a40$02c8a8c0@kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> Thanks for the idea. Unfortunately, it didn't help. :(
> 
> Blocks definitely do begin hitting the disk much sooner after I begin the
> transfer, but the overall time is basically unchanged: 7:08. vmstat still 
> shows the widely oscillating bo value.

Here's what I get with 2.4.12-ac3-lowlatency (non-fixed X11 driver):
http://www.pp.song.fi/~visitor/latencytest/3x256.html

And here's 2.4.16-lowlatency (non-fixed X11 driver):
http://www.pp.song.fi/~visitor/latencytest2/3x256.html

Here's 2.4.16-lowlatency with some small patches (fixed X11 driver):
http://www.pp.song.fi/~visitor/latencytest3/3x256.html

Here's 2.4.17-ide-rmap-O1-minill (fixed X11 driver):
http://www.pp.song.fi/~visitor/latencytest4/3x256.html


So, only usable kernel is still 2.4.12-ac3 with fixed X11 driver.


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers


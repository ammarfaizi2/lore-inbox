Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266886AbUBGMLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 07:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266889AbUBGMLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 07:11:48 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:58552 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266886AbUBGMLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 07:11:41 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Sat, 7 Feb 2004 09:11:42 +0000
User-Agent: KMail/1.6
References: <200402041820.39742.wnelsonjr@comcast.net> <200402060006.32732.wnelsonjr@comcast.net> <20040207004700.0dd5e626.mikeserv@bmts.com>
In-Reply-To: <20040207004700.0dd5e626.mikeserv@bmts.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402070911.42569.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem still occurs :-(



09:03:17 [root@murilo:~]#cat /proc/version
Linux version 2.6.3-rc1 (root@murilo) (gcc version 3.3.2) #2 Sat Feb 7 08:24:31 UTC 2004
09:03:20 [root@murilo:~]#
09:03:20 [root@murilo:~]#dmesg | grep psmouse
psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
09:03:41 [root@murilo:~]#
09:04:45 [root@murilo:~]#uptime
 09:04:49 up 39 min,  0 users,  load average: 0.08, 0.16, 0.15
09:04:49 [root@murilo:~]#
09:10:46 [root@murilo:~]#dmesg | grep time
Using tsc for high-res timesource
Machine check exception polling timer started.
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:02.2 to 64
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:02.1 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
09:11:11 [root@murilo:~]#


Em Sáb 07 Fev 2004 05:47, Mike Houston escreveu:
> On Fri, 6 Feb 2004 00:06:32 -0800
> Walt Nelson <wnelsonjr@comcast.net> wrote:
> 
> > I am not sure but patch-2.6.2-bk1.tar.gz has not produce the mouse problems. I 
> > applied it about 14 hours ago. I have no seen any mouse problems. I noticed 
> > that there was a possible fix for loosing ticks in it?
> > 
> 
> Well, I've been running 2.6.2-bk2 for around 12 hours now, and the problem hasn't surfaced. While this is the longest I've gone, it still could be coincidence but I'm hoping that strange mouse glitch won't come back.
> 
> I'm going to move on to 2.6.3-rc1 now. Here's to having nothing to report :-)
> 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

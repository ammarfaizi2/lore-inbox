Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbTAOAne>; Tue, 14 Jan 2003 19:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTAOAne>; Tue, 14 Jan 2003 19:43:34 -0500
Received: from smtp.terra.es ([213.4.129.129]:722 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id <S265506AbTAOAnd>;
	Tue, 14 Jan 2003 19:43:33 -0500
Date: Wed, 15 Jan 2003 01:52:40 +0100
From: Arador <diegocg@teleline.es>
To: Martijn Uffing <mp3project@cam029208.student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG/WARNING?] 2.5.57 ALSA sound/core/pcm_lib.c
Message-Id: <20030115015240.43b32832.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0301150122520.13717-100000@cam029208.student.utwente.nl>
References: <Pine.LNX.4.44.0301150122520.13717-100000@cam029208.student.utwente.nl>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003 01:27:37 +0100 (CET)
Martijn Uffing <mp3project@cam029208.student.utwente.nl> wrote:

> Ave people.
> 
> In 2.5.57 I get a bug/warning  when I'm using xmms. Xmms is configured for 
> OSS output,and the kernel is configured for ALSA sound including OSS emulation.
> 
> The following message is found in dmesg.
> "ALSA sound/core/pcm_lib.c:123: Unexpected hw_pointer value (stream = 0, 
> delta: -280, max jitter = 8192): wrong interrupt acknowledge? "
> I tried to reproduce the error and got another one. Only know the 
> delta 
> is -1008.

Something that resembles
ALSA sound/core/pcm_lib.c:187: Unexpected hw_pointer value (stream = 0, delta: -63, max jitter = 4064): wrong interrupt acknowledge?

but with
> # CONFIG_SND_VIA82XX is not set
this enabled (i sent a mail to the alsa
list With a full-featured bug)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSGGSO3>; Sun, 7 Jul 2002 14:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSGGSO2>; Sun, 7 Jul 2002 14:14:28 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:61395 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316339AbSGGSO1>; Sun, 7 Jul 2002 14:14:27 -0400
Date: Sun, 7 Jul 2002 20:35:01 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide__sti usage
In-Reply-To: <Pine.SOL.4.30.0207071859330.1945-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0207072034060.1441-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2002, Bartlomiej Zolnierkiewicz wrote:

> Also for most code in start_request() we dont need lock, we need it only
> for calling block layer helpers, changing/reading IDE_BUSY bit and
> ch->handler, timer and drive->rq.
> 
> Also we cannot disable interrupts, because we wont know when drive is
> interrupting us, missed irqs.

Thanks that explains quite a bit.

Cheers,
	Zwane Mwaikambo

-- 
function.linuxpower.ca


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbSLQUeE>; Tue, 17 Dec 2002 15:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbSLQUeE>; Tue, 17 Dec 2002 15:34:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63755 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267255AbSLQUeD>; Tue, 17 Dec 2002 15:34:03 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.5.49: Severe PIIX4/ATA filesystem corruption
Date: 17 Dec 2002 12:41:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ato263$v3f$1@cesium.transmeta.com>
References: <as0nq9$vnu$1@cesium.transmeta.com> <1038357146.2658.105.camel@irongate.swansea.linux.org.uk> <3DE40E29.4040408@zytor.com> <1038359021.3267.110.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1038359021.3267.110.camel@irongate.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> I would be interested to know what happens if you boot a base 2.5.49
> without raid6 adulteration and stress it on your hw there, just to be
> sure.
> 

Well, I finally got the system up and running again, after moving, and
ran it without loading any of the md modules (thus nothing modified by
the raid6 code.)  Leaving it running overnight at the shell prompt but
cron jobs running -- including the one that backs up the SCSI drives
onto the IDE drive -- left me with tons of ext3fs error messages in
the morning on the IDE drive in question.

This is unfortunately all the information I have right at the moment.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274296AbRITDSz>; Wed, 19 Sep 2001 23:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274298AbRITDSp>; Wed, 19 Sep 2001 23:18:45 -0400
Received: from [24.254.60.31] ([24.254.60.31]:3756 "EHLO
	femail37.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274296AbRITDSe>; Wed, 19 Sep 2001 23:18:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, brian@worldcontrol.com
Subject: Re: Re[2]: Athlon: Try this (was: Re: Athlon bug stomping #2)
Date: Wed, 19 Sep 2001 20:17:38 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0109140430540.2204-100000@jacui> <1663026712.20010919161037@port.imtp.ilyichevsk.odessa.ua> <01091916564902.00579@c779218-a>
In-Reply-To: <01091916564902.00579@c779218-a>
MIME-Version: 1.0
Message-Id: <01091920173800.01212@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a new one:
http://zerowing.idsoftware.com/linux/q3a/
I have an AMD CPU and a kernel 2.4.*, Quake III Arena is slowing down to 
a complete stop after a while?

It seems the 3DNow! copy routines have issues with the southbridge chip 
in the KT133A, this results in performances degrading while playing for a 
while. Re-compile your kernel without 3DNow! instructions to avoid the 
problem, and wait for newer kernels with better support for 3DNow! / 
KT133A.


Anyone know further details on this and if it's in any way connected with 
the current K7 optimization problems in the kernel?

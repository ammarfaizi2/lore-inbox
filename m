Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269436AbRHWSId>; Thu, 23 Aug 2001 14:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269649AbRHWSIW>; Thu, 23 Aug 2001 14:08:22 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:57761 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S269436AbRHWSIR>; Thu, 23 Aug 2001 14:08:17 -0400
Message-Id: <4.3.1.0.20010823110325.01ffb460@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Thu, 23 Aug 2001 11:07:26 -0700
To: george anzinger <george@mvista.com>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: tasklet question...
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
        "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B853D40.33BD96D9@mvista.com>
In-Reply-To: <4.3.1.0.20010822153241.01f40100@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Does the tasklet get run again on the same interrupt (assuming that
>tasklets are run at the end of irq processing) or the next one ?
It will be run as soon as possible e.g. won't wait for the next interrupt.

>If the same, it would seem to be better to just do it.
Nop. You should be nice to other tasklets/softirqs.

Max 

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net


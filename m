Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272151AbRHVWeB>; Wed, 22 Aug 2001 18:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272152AbRHVWdv>; Wed, 22 Aug 2001 18:33:51 -0400
Received: from miro.qualcomm.com ([129.46.64.223]:44256 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S272151AbRHVWde>; Wed, 22 Aug 2001 18:33:34 -0400
Message-Id: <4.3.1.0.20010822153241.01f40100@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Wed, 22 Aug 2001 15:33:22 -0700
To: "Raj, Ashok" <ashok.raj@intel.com>,
        "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: tasklet question...
In-Reply-To: <9319DDF797C4D211AC4700A0C96B7C9404AC2171@orsmsx42.jf.intel
 .com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>processing in the tasklet would like to reschedule tasklet again. will the following work
>
>tasklet_function()
>{
>         more_processing = DeferredProcessing()
>             if (more_processing)
>                tasklet_schedule() // this will schedule the same tasklet.
>}
>
>is the above legal.
It's fine and it will work.

Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net


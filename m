Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbTBLOMS>; Wed, 12 Feb 2003 09:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266955AbTBLOLX>; Wed, 12 Feb 2003 09:11:23 -0500
Received: from fep19-0.kolumbus.fi ([193.229.0.45]:49119 "EHLO
	fep19-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S267162AbTBLOJo>; Wed, 12 Feb 2003 09:09:44 -0500
From: <mika.penttila@kolumbus.fi>
To: Jamie Lokier <jamie@shareable.org>,
       Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>
Subject: Re: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Date: Wed, 12 Feb 2003 16:19:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-Id: <20030212141933.CKGK3999.fep19-app.kolumbus.fi@[193.229.5.109]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, why is sysenter supposed to be disabled while in vm86? And if it should be disabled (as now in sys_vm86), the next context switch back to the vm86 process re-enables it, in load_esp0, right? So what's the gain?

--Mika





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbTBYH7i>; Tue, 25 Feb 2003 02:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbTBYH7i>; Tue, 25 Feb 2003 02:59:38 -0500
Received: from webmail.frogspace.net ([216.222.206.4]:40341 "EHLO
	webmail.frogspace.net") by vger.kernel.org with ESMTP
	id <S267806AbTBYH7h>; Tue, 25 Feb 2003 02:59:37 -0500
Message-ID: <1046160591.3e5b24cfb20de@webmail.cogweb.net>
Date: Tue, 25 Feb 2003 00:09:51 -0800
From: Peter Nome <peter@cogweb.net>
To: linux-kernel@vger.kernel.org
Cc: Krishnakumar B <kitty@cse.wustl.edu>
Subject: Re: Linux 2.4.20, Athlon MP and Promise PDC20276 IDE controller
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 128.97.184.97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Krishnakumar,

"Am I right in assuming that Linux doesn't enable DMA on this controller? How do I
determine if DMA is enabled for a ide controller apart from relying on the
boot message?"

As you suspect, you're getting DMA all right -- you see it in the boot message too, 
as UDMA(133). To confirm, issue

hdparm /dev/hde

Looks good!

Cheers,
Peter

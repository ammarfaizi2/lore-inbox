Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLGT1c>; Thu, 7 Dec 2000 14:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLGT1W>; Thu, 7 Dec 2000 14:27:22 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:16140 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129226AbQLGT1J>;
	Thu, 7 Dec 2000 14:27:09 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012071856.VAA32249@ms2.inr.ac.ru>
Subject: Re: [Fwd: lost need_resched flag re-introduced?]
To: jsun@mvista.com (Jun Sun)
Date: Thu, 7 Dec 2000 21:56:23 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A2FDC3C.C2DA705D@mvista.com> from "Jun Sun" at Dec 7, 0 10:51:40 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I think wake_up_process() is called in interrupt routine quite often and it
> will set need_resched flag (through reschedule_idle()).  ???

It sets _right_ flag cpu_curr(this_cpu)->need_resched, rather than
current->need_resched.



> happening.  Ether some new code takes care of it.  Or it is still there.

?  8)

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

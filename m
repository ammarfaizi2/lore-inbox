Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273446AbRIULtV>; Fri, 21 Sep 2001 07:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273450AbRIULtL>; Fri, 21 Sep 2001 07:49:11 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61714 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273446AbRIULtF>; Fri, 21 Sep 2001 07:49:05 -0400
Subject: Re: probable hardware bug: clock timer configuration lost
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Fri, 21 Sep 2001 12:54:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        wolfy@nobugconsulting.ro (lonely wolf), linux-kernel@vger.kernel.org
In-Reply-To: <20010920221610.A14451@redhat.com> from "Benjamin LaHaise" at Sep 20, 2001 10:16:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kOso-000878-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Odd, I just got this during booting of my ALi based boards (never had seen 
> it before).  Are we certain the test is correct?

Not entirely thats why I havent sent that specific change on to Linus.
(He has the quiet early fix one which is vital to boot some old VIA boxes
 but not that one)

If you have a box with he thing triggering and a moment of time, tweak the
code to read "low1, high, low2, high2" and take min(low1,low2), with high1
as the test.

Alan

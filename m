Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281129AbRK3Wci>; Fri, 30 Nov 2001 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281077AbRK3Wcc>; Fri, 30 Nov 2001 17:32:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21253 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281129AbRK3WcK>; Fri, 30 Nov 2001 17:32:10 -0500
Subject: Re: [PATCH] task_struct colouring ...
To: davidel@xmailserver.org (Davide Libenzi)
Date: Fri, 30 Nov 2001 22:40:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (lkml),
        yamamura@flab.fujitsu.co.jp (Shuji YAMAMURA)
In-Reply-To: <Pine.LNX.4.40.0111301326160.1600-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Nov 30, 2001 01:47:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169wL1-00052x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looking at both the Manfred and Fujitsu patches I propose this new version
> for task struct colouring.
> The patch from Manfred is too architecture dependent ( cr2 ) and storing
> extra stuff in CPU registers is not IMHO a good idea.

Well the whole "current" handling is entirely architecture dependant anyway.
On most saner platforms current is a global register variable (the wonders
of gcc) and the whole problem simply isnt there

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRC0LAo>; Tue, 27 Mar 2001 06:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRC0LAf>; Tue, 27 Mar 2001 06:00:35 -0500
Received: from 13dyn107.delft.casema.net ([212.64.76.107]:39435 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131191AbRC0LAS>; Tue, 27 Mar 2001 06:00:18 -0500
Message-Id: <200103271059.MAA18765@cave.bitwizard.nl>
Subject: OOM killer???
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2001 12:59:34 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a quick bug-report: 

One of our machines just started spewing:

Out of Memory: Killed process 117 (sendmail).
Out of Memory: Killed process 117 (sendmail).
Out of Memory: Killed process 117 (sendmail).
Out of Memory: Killed process 117 (sendmail).
Out of Memory: Killed process 117 (sendmail).
Out of Memory: Killed process 117 (sendmail).
Out of Memory: Killed process 117 (sendmail).
Out of Memory: Killed process 117 (sendmail).
Out of Memory: Killed process 117 (sendmail).

What we did to run it out of memory, I don't know. But I do know that
it shouldn't be killing one process more than once... (the process
should not exist after one try...)

Kernel 2.4.0 .

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTEHVSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTEHVSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:18:05 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:7377 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262115AbTEHVSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:18:05 -0400
Subject: MTRR 1 not used?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1052429374.660.24.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 08 May 2003 23:29:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I can see a lot of "MTRR 1 not used" messages when the X server ends or
is restarted while running 2.5.69-mmx.

# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xfd000000 (4048MB), size=   8MB: write-combining, count=1

I have an ATI RAGE Mobility M1 AGP with 8MB video card. I have never
seen this message on 2.4 kernels. What does this mean?

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTDRRXC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbTDRRXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:23:02 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:45012 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263176AbTDRRXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:23:00 -0400
Subject: 2.5.67-mm4: select-speedup.patch breaks Evolution
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: akpm@digeo.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050687280.595.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 18 Apr 2003 19:34:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.67-mm4 breaks Evolution 1.2.3: when clicking on "Sending/Receiving"
toolbar button, Evolution displays the progress dialog box but it hangs
forever, that is, no mail is sent or received. All my accounts are POP3.

Reverting "select-speedup.patch" fixes the problem.

-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198


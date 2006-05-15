Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWEORpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWEORpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWEORpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:45:12 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:13258 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S965067AbWEORow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:44:52 -0400
X-ASG-Debug-ID: 1147715091-19777-84-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
X-ASG-Whitelist: Client
Reply-To: <ravinandan.arakali@neterion.com>
From: "Ravinandan Arakali" <ravinandan.arakali@neterion.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Peter. Phan" <peter.phan@neterion.com>,
       "Leonid Grossman" <Leonid.Grossman@neterion.com>
X-ASG-Orig-Subj: MSI-X support on AMD 8132 platforms ?
Subject: MSI-X support on AMD 8132 platforms ?
Date: Mon, 15 May 2006 10:44:47 -0700
Message-ID: <MAEEKMLDLDFEGKHNIJHIKEIMCEAA.ravinandan.arakali@neterion.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
In-Reply-To: <MAEEKMLDLDFEGKHNIJHIOECKCEAA.ravinandan.arakali@neterion.com>
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I was wondering if anybody has got MSI-X going on AMD 8132 platforms.
Our network card and driver support MSI-X and the combination works
fine on IA64 and xeon platforms. But on the 8132, the MSI-X vectors are
assigned(pci_enable_msix succeeds) but no interrupts get generated.
Note that with a different OS, MSI-X does work on 8132.

Any suggestions are appreciated.

Thanks,
Ravi


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbVLFP0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbVLFP0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbVLFP0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:26:13 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:9199 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751707AbVLFP0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:26:12 -0500
From: "David Engraf" <engraf.david@netcom-sicherheitstechnik.de>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] Win32 equivalent to GetTickCount systemcall (i386)
Date: Tue, 6 Dec 2005 16:25:59 +0100
Message-ID: <001b01c5fa79$62fea6d0$0a016696@EW10>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <p73u0dmqa84.fsf@verdi.suse.de>
Thread-Index: AcX6eCACdUDMiCluR4S8gWsYnbY8fAAARM7A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:79a9c929f10b28b00e544b1aedb42267
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Engraf" <engraf.david@netcom-sicherheitstechnik.de> writes:
> 
> > This patch adds a new systemcall on i386 architectures returning the
> jiffies
> > value to the application.
> > As a kernel developer you can use jiffies but from the user space there
> is
> > no equivalent function which counts every millisecond like the Win32
> > GetTickCount.
> 
> You want a timer that never go backwards, right?
> 
> Use clock_gettime(CLOCK_MONOTONIC). It's the POSIX way to do this.
> 
> -Andi

Yes, clock_gettime works(CLOCK_MONOTONIC), thanks.

David


____________
Virus checked by G DATA AntiVirusKit
Version: AVK 16.2042 from 06.12.2005
Virus news: www.antiviruslab.com


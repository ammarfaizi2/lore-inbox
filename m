Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbUKEIeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbUKEIeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 03:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbUKEIeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 03:34:50 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:43960 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262630AbUKEIej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 03:34:39 -0500
Subject: IO_APIC NMI Watchdog not handled by suspend/resume.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1099643612.3793.3.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 05 Nov 2004 19:33:32 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Tracking down SMP problems, I've found that if you boot with
nmi_watchdog=1 (IO_APIC), the watchdog continues to run while suspend is
doing sensitive things like restoring the original kernel. I don't know
enough to provide a patch to disable it so thought I'd ask if someone
could volunteer to fix this?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6


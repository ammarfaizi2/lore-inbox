Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTLAHyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLAHyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:54:05 -0500
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:12188 "EHLO
	catv-50624ad9.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S261807AbTLAHx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:53:58 -0500
Message-ID: <3FCAF390.10202@freemail.hu>
Date: Mon, 01 Dec 2003 08:53:52 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031030
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ACPI does not power off the machine automatically
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a n ABit BP6 board with 2 Celeron/400MHz with the latest
released version RU (beta) BIOS, it was released in 2000.

I am running 2.6.0-test10-mm1 at present
and it does not power off the machine. It writes

acpi_power_off called

at the end and stops there. But when I press Alt+SysRQ+o,
it switches off. 1 out of (maybe) 50 occasions, the machine
can switch itself off automatically.

But it worked earlier, I don't know which kernel it was.

I have to pass acpi=force to get ACPI working because of the
BIOS date but it seems to work OK although I get some weird ACPI
status messages during kernel boot. It writes something like
\_PR_\CPU0 is missing from a (don't remember which) table.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.


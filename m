Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVCDH7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVCDH7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbVCDH7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:59:21 -0500
Received: from [209.203.41.250] ([209.203.41.250]:63119 "EHLO
	bventer01.shoden.co.za") by vger.kernel.org with ESMTP
	id S262615AbVCDH7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:59:07 -0500
Message-ID: <42281543.9040901@shoden.co.za>
Date: Fri, 04 Mar 2005 09:58:59 +0200
From: Bennie Kahler-Venter <bennie.venter@shoden.co.za>
Reply-To: bennie.venter@shoden.co.za
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: v.2.6.11 mouse still losing sync and thus jumping around
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using SuSE 9.1 Professional with kernel 2.6.11  running on a AOpen 1845
Laptop.

Currently running without APM & ACPI

If I turn either or both on I get an erratic mouse and entries such as
these:
Mar  3 15:06:55 bventer01 kernel: psmouse.c: Mouse at
isa0060/serio2/input0 lost synchronization, throwing 2 bytes away.
Mar  3 15:07:23 bventer01 kernel: psmouse.c: Mouse at
isa0060/serio2/input0 lost synchronization, throwing 2 bytes away.

Kernels 2.6.x all reproduce the above symptoms.  I'm currently running
on 2.6.11

Must say that the occurance of these erratic problems are a lot less in
2.6.11 but they still persist.  I did do a test to see if it was ACPI
related.

With ACPI and APM turned on and when I restart "powersaved" mouse goes
crazy without me touching it.  I'm not too sure how to progress to
locate/fix this problem.

Tnx & Bi
Bennie Kahler-Venter




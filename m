Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUL1R1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUL1R1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUL1R1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 12:27:31 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:26533 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261197AbUL1R13
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 12:27:29 -0500
Message-ID: <41D1977D.2000600@drzeus.cx>
Date: Tue, 28 Dec 2004 18:27:25 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: APIC, changing level/edge interrupt
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do you tell the APIC that a device uses level triggered interrupts, 
not edge triggered? I have a flash reader on the LPC bus which uses 
level triggered interrupts and /proc/interrupts show edge triggered. 
Some interrupts are missed by the APIC so I figured this might be why.

Rgds
Pierre

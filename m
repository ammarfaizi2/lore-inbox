Return-Path: <linux-kernel-owner+w=401wt.eu-S932773AbWL0VeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbWL0VeS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWL0VeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:34:18 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:48893 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932773AbWL0VeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:34:17 -0500
Message-ID: <4592E685.5000602@gmail.com>
Date: Wed, 27 Dec 2006 22:32:53 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: dmitry.torokhov@gmail.com
Subject: [BUG 2.6.20-rc2] atkbd.c: Spurious ACK
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day.

The bug where the kernel repetitively emits "atkbd.c: Spurious ACK on 
isa0060/serio0. Some program might be trying access hardware directly" 
(sic) on a panic, thereby scrolling away the information that would help 
in seeing what exactly the problem was (ie, "Unable to mount root fs" or 
something) is still present in 2.6.20-rc2.

Rene.

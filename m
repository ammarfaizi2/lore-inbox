Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWCUUw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWCUUw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWCUUw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:52:28 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:452
	"EHLO rc-vaio.rcdiostrouska.com") by vger.kernel.org with ESMTP
	id S964849AbWCUUw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:52:27 -0500
Subject: p4-clockmod not working in 2.6.16
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 21 Mar 2006 21:55:28 +0100
Message-Id: <1142974528.3470.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

I would like to advise you that in kernel 2.6.16 the 
p4-clockmod module cant recognise my P4 cpu anymore.

This worked perfectly in kernel 2.6.15. I get the following
error when I modprobe it:

root@rc-vaio:/home/sasa# modprobe msr && modprobe cpuid && modprobe
p4_clockmod && modprobe speedstep-lib && modprobe microcode && modprobe
hwmon
FATAL: Error inserting p4_clockmod
(/lib/modules/2.6.16/kernel/arch/i386/kernel/cpu/cpufreq/p4-clockmod.ko): No such device

Can somebody explain what happened or how can I set it up ?

Many thanks and best regards
Sasa Ostrouska




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUKPTsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUKPTsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 14:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUKPTsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 14:48:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30395 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261779AbUKPTq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 14:46:26 -0500
Date: Tue, 16 Nov 2004 20:46:25 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Work around a lockup?
Message-ID: <Pine.LNX.4.53.0411162038490.8374@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I am currently looking into an issue where a host sporadically locks up. I will
retrieve the SYSRQ+P tomorrow when I am back at the machine.
Until then, here's the real question:

Given that some kernel code (possibly a module) runs in an infinite loop, and
thus not giving back control to the user (in an UP environment), is there a
possibility to force a schedule?
Something like the normal scheduler does to processes ("you got your timeslice,
and not more"), but also when they are in kernel mode.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de

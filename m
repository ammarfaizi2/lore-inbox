Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTK0PqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 10:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTK0PqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 10:46:24 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:59908 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S264542AbTK0PqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 10:46:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Selecting CPU frequency on Asus P4M laptop
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 27 Nov 2003 16:46:20 +0100
Message-ID: <yw1x65h5ddbn.fsf@kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an Asus M2E laptop with a 1.8 GHz P4M CPU.  Using the 'acpi'
cpufreq driver, I can select between 1.8 GHz and 1.2 GHz, thereby
changing the power consumption.  If I boot the machine with the AC
adapter disconnected, it starts off at 1.2 GHz.  After that, I can
lower it to 800 MHz using cpufreq.  In short, cpufreq will be able to
choose among one of two pairs of frequencies, which depend on the
status of the AC adapter at boot time.

Is there any way to change which of these will be used after booting?

-- 
Måns Rullgård
mru@kth.se

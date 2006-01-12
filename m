Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161360AbWALWRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161360AbWALWRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161364AbWALWRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:17:42 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:45528 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161360AbWALWRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:17:42 -0500
Subject: Dual core Athlons and unsynced TSCs
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 17:17:39 -0500
Message-Id: <1137104260.2370.85.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's been known for quite some time that the TSCs are not synced between
cores on Athlon X2 machines and this screws up the kernel's timekeeping,
as it still uses the TSC as the default time source on these machines.

This problem still seems to be present in the latest kernels.  What is
the plan to fix it?  Is the fix simply to make the kernel use the ACPI
PM timer by default on Athlon X2?

Lee


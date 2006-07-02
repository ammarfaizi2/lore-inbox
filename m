Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWGBKsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWGBKsD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 06:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWGBKsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 06:48:02 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:12475 "EHLO
	idefix.homelinux.org") by vger.kernel.org with ESMTP
	id S932232AbWGBKsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 06:48:01 -0400
Subject: Suspend to RAM regression tracked down
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
Date: Sun, 02 Jul 2006 20:47:47 +1000
Message-Id: <1151837268.5358.10.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A while ago, I reported a suspend to RAM regression (fail to resume). I
have since then tracked down the regression to the changes between
2.6.12-rc5-git5 and 2.6.12-rc5-git6. On my laptop, I have only been able
to reproduce the problem with the ondemand cpufreq governor, but I've
head of another user with the same (Dell D600) laptop having problem
with the userspace governor as well. All the details are actually
http://bugzilla.kernel.org/show_bug.cgi?id=6166 but it seems like it's
being ignored. It's currently assigned to the ACPI category, but maybe
it belongs to cpufreq? Anyone can help here?

	Jean-Marc

P.S. Please CC me since I'm not subscribed to the list.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTIPNeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTIPNeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:34:12 -0400
Received: from yonge.cs.toronto.edu ([128.100.1.8]:36248 "HELO
	yonge.cs.toronto.edu") by vger.kernel.org with SMTP id S261874AbTIPNeL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:34:11 -0400
Date: Tue, 16 Sep 2003 09:19:30 -0400
From: Behdad Esfahbod <behdad@cs.toronto.edu>
X-X-Sender: behdad@dvp.cs
To: linux-kernel@vger.kernel.org
Subject: standby and suspend with acpi in 2.6.0-test5
Message-ID: <Pine.GSO.4.44.0309160916180.15025-100000@dvp.cs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please keep me CCed]
Hi again,

With 2.6.0-test5, reading the docs, I found that to standby of
suspend, I should try writing to /sys/power/state, but doing so
makes it to try load apm module as it opens /dev/apmbios.  So the
questions are:

	* Is swsusp patches merged with the kernel?
	* How should I suspend/standby with acpi enabled?
	* Where is /proc/acpi/sleep gone?  It used to kinda work.

behdad


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUAMWXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265873AbUAMWXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:23:15 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:128 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265856AbUAMWXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:23:10 -0500
Date: Tue, 13 Jan 2004 23:22:56 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI directories still exist with acpi off
Message-ID: <20040113222254.GA553@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This seems to be generic bug:

Include acpi support into the kernel, but pass acpi=off on the command
line. Somehow, acpi still manages to create its directories, but not
in /proc/acpi but in /proc directly. Ouch.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

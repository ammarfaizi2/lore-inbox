Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTILJrB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTILJrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:47:01 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:61824 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261375AbTILJrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:47:00 -0400
Date: Fri, 12 Sep 2003 11:00:44 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309121000.h8CA0iYY001434@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org
Subject: F0 0F bug workaround enabled for CONFIG_MK6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed that CONFIG_X86_F00F_WORKS_OK is left undefined when
configuring for CONFIG_MK6.

Will a kernel compiled for that CPU family actually run on any CPU
that has the F00F bug?  If not, we're compiling in an, (admittedly
tiny), amount of superflous code in arch/i386/kernel/setup.c

John.

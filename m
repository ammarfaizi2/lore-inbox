Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbVIOFR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVIOFR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 01:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965196AbVIOFRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 01:17:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965144AbVIOFRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 01:17:25 -0400
Date: Wed, 14 Sep 2005 22:16:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/7] s390: default configuration.
Message-Id: <20050914221650.0e5b8e49.akpm@osdl.org>
In-Reply-To: <20050914155308.GA27169@skybase.boeblingen.de.ibm.com>
References: <20050914155308.GA27169@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'd propose that these:

s390-default-configuration.patch
s390-bl_dev-array-size.patch
s390-crypto-driver-patch-take-2.patch
s390-show_cpuinfo-fix.patch
s390-diag-0x308-reipl.patch

are 2.6.14 material whereas these:

s390-3270-fullscreen-view.patch
s390-ipl-device.patch

aren't (at least, yet).  I've asked Greg to take a look at the sysfs stuff
in the last two patches.

OK?

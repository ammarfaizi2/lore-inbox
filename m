Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161438AbWJSOax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161438AbWJSOax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161437AbWJSOax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:30:53 -0400
Received: from mxsf32.cluster1.charter.net ([209.225.28.156]:17108 "EHLO
	mxsf32.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1161435AbWJSOaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:30:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17719.35854.477605.398170@smtp.charter.net>
Date: Thu, 19 Oct 2006 10:30:38 -0400
From: "John Stoffel" <john@stoffel.org>
To: Avi Kivity <avi@qumranet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] KVM: userspace interface
In-Reply-To: <453781F9.3050703@qumranet.com>
References: <4537818D.4060204@qumranet.com>
	<453781F9.3050703@qumranet.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avi> This patch defines a bunch of ioctl()s on /dev/kvm.  The ioctl()s
Avi> allow adding memory to a virtual machine, adding a virtual cpu to
Avi> a virtual machine (at most one at this time), transferring
Avi> control to the virtual cpu, and querying about guest pages
Avi> changed by the virtual machine.

Yuck.  ioclts are deprecated, you should be using /sysfs instead for
stuff like this, or configfs.  

John

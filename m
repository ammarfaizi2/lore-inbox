Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUDORml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUDORlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:41:55 -0400
Received: from emulex.emulex.com ([138.239.112.1]:50897 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S263141AbUDORjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:39:14 -0400
Message-ID: <3356669BBE90C448AD4645C843E2BF2802C0168A@xbl.ma.emulex.com>
From: "Smart, James" <James.Smart@Emulex.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: persistence of kernel object attribute ??
Date: Thu, 15 Apr 2004 13:39:11 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been looking at everything I can find, asked a few questions, and don't
have an answer to the following issue.

I have a driver that wants to export attributes per instance. I'd like the
ability for the user to modify an attribute dynamically (sysfs works well) -
but I'd like the new value to be persistent the next time the driver
unloads/loads or the system reboots.  I don't want to have to update
constants in source and recompile the driver.  I'm looking for something
similar (cringe!) to the MS registry.  Is there a facility available to
kernel objects to allow for persistent attributes to be set/retrieved? If
not, any recommendations on how to implement this ?

-- james


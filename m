Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVBAQpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVBAQpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVBAQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:45:42 -0500
Received: from mout.perfora.net ([217.160.230.40]:31724 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S262064AbVBAQpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:45:38 -0500
Subject: x86-64 LSM BSD Securelevel module
From: Christopher Warner <chris@servertogo.com>
To: linux-kernel@vger.kernel.org, zanee@kernelcode.com
Content-Type: text/plain
Date: Tue, 01 Feb 2005 06:58:47 -0500
Message-Id: <1107259127.27124.107.camel@linux-cw>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with 2.6.10 on x86_64 arch.

I've compiled BSD securelevel support into 2.6.10 (directly into the
kernel and via a module) and am receiving the following error below:

seclvl: seclvl_init: seclvl: Failure registering with the kernel.
seclvl: seclvl_init: seclvl: Failure registering with primary security
module.
seclvl: Error during initialization: rc = [-22]

However;
Security Framework v1.0.0 initialized
Capability LSM initialized

Obviously it doesn't provide seclvl info on sys because it can't
register. LSM has been compiled directly into the kernel and is loading
fine so I'm at a loss as to why exactly it can't register.

I haven't investigated much further, is this an int/arch problem?

-- 
Christopher Warner


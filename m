Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTKLTLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 14:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTKLTLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 14:11:08 -0500
Received: from math.ut.ee ([193.40.5.125]:17092 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264202AbTKLTLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 14:11:07 -0500
Date: Wed, 12 Nov 2003 21:11:03 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-rc1 depmod failure of w9968cf - I2C dependency
Message-ID: <Pine.GSO.4.44.0311121841470.6834-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on sparc64 where I2C seems to have some problems.

depmod: *** Unresolved symbols in /lib/modules/2.4.23-rc1/kernel/drivers/usb/w9968cf.o
depmod:         i2c_add_adapter_Rd0bcafe7
depmod:         i2c_del_adapter_R35adeeff

Probaly this module should have an explicit dependency on I2C.

-- 
Meelis Roos (mroos@linux.ee)




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbTABUN6>; Thu, 2 Jan 2003 15:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbTABUN6>; Thu, 2 Jan 2003 15:13:58 -0500
Received: from smtp.comcast.net ([24.153.64.2]:7024 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S266433AbTABUN5>;
	Thu, 2 Jan 2003 15:13:57 -0500
Date: Thu, 02 Jan 2003 15:36:52 -0500
From: "Jonathan S. Shapiro" <shap@eros-os.org>
Subject: new PCI ID in eepro100.c
To: linux-kernel@vger.kernel.org
Message-id: <1041539812.8497.7.camel@deskjob.eros-os.org>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new Toshiba tablet PC's (and probably some other devices by now) are
shipping with a new version of the eepro100 onboard ethernet chip. The
only problem is that the PCI ID isn't recognized by Linux (2.4.18,
eepro100.c). I got it working simply by adding the following line to the
PCI device table in eepro100.c:

	{ PCI_VENDOR_ID_INTEL, 0x1059, PCI_ANY_ID, PCI_ANY_ID, },

Would you be kind enough to add this to the official driver if it hasn't
already been done?

Thanks

Jonathan Shapiro
(The EROS Guy)



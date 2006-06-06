Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWFFJuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWFFJuH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWFFJuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:50:06 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:30091 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932140AbWFFJuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:50:05 -0400
Message-Id: <1149587406.28634.263152113@webmail.messagingengine.com>
X-Sasl-Enc: IE4RAyXnCQs/IbUaCYl0tQQDz2eKwm3JCtfmQFXTO02e 1149587406
From: "Ivan Novick" <ivan@0x4849.net>
To: linux-kernel@vger.kernel.org
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 5022  (F2.72; T1.15; A1.62; B3.04; Q3.03)
Subject: #define pci_module_init pci_register_driver
Date: Tue, 06 Jun 2006 10:50:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems an effort was made to replace all pci_module_init calls with
pci_register_driver but in -mm it still seems to have pci_module_init
for many drivers.

Does anyone know if this is still in the queue somewhere or if it was
cancelled?  Is pci_register_driver the preferred call to make?

Thanks for any info,

Ivan 

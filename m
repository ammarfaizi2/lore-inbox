Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWJWDUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWJWDUx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWJWDUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:20:53 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:50615 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751317AbWJWDUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:20:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aG9pGxnDTOw5kVMdk5pDQAQjqXyUv0PnfzdSz9Jyf35bxvDKSCSfOBtD34hZzMOGpzZvQ8MfWY88LzdNxq40d+wPjYid6sVkEvJiGEEKT/iepIHaPcH8uzFqUaEz3elJX5ebAZyKkJGQQU96w0lOzPuYphj14IBFqpAt4cGfyQQ=
Message-ID: <b6a2187b0610222020o5ed1e463k7f5b7c133b804293@mail.gmail.com>
Date: Mon, 23 Oct 2006 11:20:51 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc2 tg3 cannot find proper pci device base address
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this error on with linux 2.6.19-rc2 with tg3 module, even
with patching to v3.66 ...

tg3.c:v3.67 (October 18, 2006)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
tg3: Cannot find proper PCI device base address, aborting.
ACPI: PCI Interrupt for device 0000:02:00.0 disabled

The last version 2.6.18-rc2 works fine.

Jeff.

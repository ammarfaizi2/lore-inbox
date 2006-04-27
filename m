Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWD0XiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWD0XiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 19:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWD0XiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 19:38:01 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:46901 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751247AbWD0XiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 19:38:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kzonkdituxJdp9zXupcyu9ZDRKS0RgT0GnwFfctAmNRyruVngvbZc14Qmdud0Jt2K7ESRvpF9iyINt50PsUJeA44yjA/DnoW9AWL2PhaGRQLiBJHkR0HVGeIB2wY81sqQblH+RBkGYzwaAYr9VG5CxCzyq0k2LTjipWzVKZhmjg=
Message-ID: <7da560840604271637n65106962k180234c116614d94@mail.gmail.com>
Date: Thu, 27 Apr 2006 16:37:59 -0700
From: "Muthu Kumar" <muthu.lkml@gmail.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: functions named similar (pci_acpi_init)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
While looking at something else, got drifted to looking into
initcall<n>.init. I found two instance of pci_acpi_init() function,
one in drivers/pci/pci-acpi.c and another in i386/pci/acpi.c.
I understand this doesnot cause any problem since they are static, but
someone new looking at the code could fall for it? Is it worth
changing one of its name or should I just go away :)

Muthu.

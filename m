Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbTJAQjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTJAQgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:36:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11171 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262424AbTJAQef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:34:35 -0400
Message-ID: <3F7B0209.7070509@pobox.com>
Date: Wed, 01 Oct 2003 12:34:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Marold <andrew.marold@wlm.edial.com>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: Serial ATA support in 2.4.22
References: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office> <3F7AEF15.1070301@pobox.com>
In-Reply-To: <3F7AEF15.1070301@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another thing to try is rather generic...  If you have ACPI on, try 
booting with "acpi=off" or "pci=biosirq" or messing around with settings 
in BIOS setup.

In general I recommend that SATA be used "native" or "enhanced" mode 
according to BIOS, and that "legacy" or "combined" mode is to be 
avoided.  (legacy mode is fine for PATA...)

	Jeff





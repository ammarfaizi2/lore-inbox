Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVCCEZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVCCEZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVCCESy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:18:54 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:25770 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261342AbVCCEPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:15:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Joshua Hudson <jwhudson@hornet.csc.calpoly.edu>
Subject: Re: Bug report -- keyboard not working Linux 2.6.11 on Inspiron 1150
Date: Wed, 2 Mar 2005 23:15:23 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0503021959520.14602-100000@hornet>
In-Reply-To: <Pine.GSO.4.44.0503021959520.14602-100000@hornet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503022315.23667.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 23:02, Joshua Hudson wrote:
> ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
> ACPI: PS/2 Mouse Controller [PS2M] at irq 12
> i8042.c: Can't read CTR while initializing i8042.

Ok, your BIOS is also reporting incorrect port values for the keyboard
controller, it should be 0x60, 0x64. You'll have to use i8042.noacpi
for now.

Thank you for the log.

-- 
Dmitry

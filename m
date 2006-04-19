Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWDSI5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDSI5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDSI5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:57:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750756AbWDSI5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:57:07 -0400
Date: Wed, 19 Apr 2006 01:56:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc1-mm3] doesn't compile (msi/smp.h compile error)
Message-Id: <20060419015623.021cef58.akpm@osdl.org>
In-Reply-To: <20060419081614.GA18239@amd64.of.nowhere>
References: <20060419045734.GA30172@amd64.of.nowhere>
	<20060419002527.185503d9.akpm@osdl.org>
	<20060419081614.GA18239@amd64.of.nowhere>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thunder7@xs4all.nl wrote:
>
> > So I think you need to send the real .config, please.
> 
>  I took this working config from 2.6.17-rc1-mm2, copied it to .config in
>  my 2.6.17-rc1-mm3 tree, ran make oldconfig, answered some questions
>  (about ACPI_DOCK, I2C_VIRT, USB_SERIAL_FUNSOFT, RTC_DRV_DS1307, and
>  it generated this .config. That should work, shouldn't it?

Again, running `make oldconfig' against this .config causes CONFIG_PCI_MSI
to get turned off.

It's pretty simple - please just send the 2.6.17-rc1-mm3 .config which
produces that compile error.

# Automatically generated make config: don't edit
# Linux kernel version: 2.6.17-rc1-mm2
# Sun Apr  9 21:28:10 2006

See, that's a -mm2 .config from ten days ago.

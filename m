Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWCYDk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWCYDk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 22:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWCYDk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 22:40:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750725AbWCYDkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 22:40:25 -0500
Date: Fri, 24 Mar 2006 22:40:13 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: smp_locks reference_discarded errors
Message-ID: <20060325033948.GA15564@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

since the addition of smp alternatives, the following is occuring..

Error: ./drivers/md/md.o .smp_locks refers to 0000008c R_386_32          .exit.text
Error: ./drivers/usb/storage/libusual.o .smp_locks refers to 00000008 R_386_32          .exit.text
Error: ./net/802/psnap.o .smp_locks refers to 00000000 R_386_32          .exit.text
Error: ./drivers/pci/hotplug/ibmphp_hpc.o .smp_locks refers to 00000008 R_386_32          .exit.text
Error: ./drivers/pci/hotplug/ibmphp_hpc.o .smp_locks refers to 0000000c R_386_32          .exit.text

example .config at http://people.redhat.com/davej/kernel-2.6.16-i686-smp.config

		Dave

-- 
http://www.codemonkey.org.uk

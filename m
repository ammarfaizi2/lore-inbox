Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWBSCJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWBSCJA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 21:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWBSCI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 21:08:59 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:51841 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S1751243AbWBSCI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 21:08:59 -0500
Date: Sat, 18 Feb 2006 21:08:47 -0500
From: Dave Jones <davej@redhat.com>
To: jirislaby@gmail.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: dvb breakage
Message-ID: <20060219020847.GA5412@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, jirislaby@gmail.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200601120808.k0C88hat012740@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601120808.k0C88hat012740@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 12:08:43AM -0800, Linux Kernel wrote:
 > tree 735e941317b10973cd06bf63bdcf1140d2ef7412
 > parent d4437d3fada351d7f40bcc48a62c12b92e2ad9d8
 > author Jiri Slaby <xslaby@fi.muni.cz> Wed, 11 Jan 2006 23:41:13 -0200
 > committer Mauro Carvalho Chehab <mchehab@brturbo.com.br> Wed, 11 Jan 2006 23:41:13 -0200
 > 
 > V4L/DVB (3344c): Pci probing for stradis driver
 > 
 > - Pci probing functions added, some functions were rewritten.
 > 
 > - Use PCI_DEVICE macro.
 > 
 > - dev_ used for printing when pci_dev available.
 > 
 > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
 > Signed-off-by: Andrew Morton <akpm@osdl.org>
 > Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>

Jiri,
 I'm not sure if this the exact cset that broke it, but 
one of our users reports that since around this time,
udev stopped creating a /dev/dvb/adaptor0

Did this inadvertantly change how things look in sysfs?

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063

		Dave


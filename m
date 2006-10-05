Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWJFOvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWJFOvk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWJFOvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:51:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39945 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161018AbWJFOvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:51:39 -0400
Date: Thu, 5 Oct 2006 10:36:57 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061005103657.GA4474@ucw.cz>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org> <20061002003908.GA18707@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002003908.GA18707@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I assume that cute userspace applications for controlling backlight
> > brightness via the generic backlight driver either exist or are in
> > progress?  What is the status of that?
> 
> For Dell laptops, the dellLcdBrightness app is included in the
> libsmbios-bin package (http://linux.dell.com/libsmbios/main/ and
> http://linux.dell.com/libsmbios/main/yum.html for the yum repo).  It's
> entirely userspace.

Please move it into the kernel where it belongs, and use lcd
brightness subsystem like everyone else.
							Pavel
-- 
Thanks for all the (sleeping) penguins.

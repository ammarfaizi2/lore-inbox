Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWG3Jna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWG3Jna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWG3Jna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:43:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:13956 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932158AbWG3Jn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:43:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: ACPI-related problem with resuming from RAM
Date: Sun, 30 Jul 2006 11:43:11 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200607301140.09836.rjw@sisk.pl>
In-Reply-To: <200607301140.09836.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301143.11698.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 July 2006 11:40, Rafael J. Wysocki wrote:
> Hi,
> 
> To make my box (Asus L5D, x86_64) resume from RAM, I have to unload all of the
> ACPI-related modules and the ohci_hcd module before the suspend.
> 
> Also, I can't reload the ohci_hcd module after the resume, because if I try,
> the system crashes with the appended trace.

The kernel is 2.6.18-rc2-mm1.

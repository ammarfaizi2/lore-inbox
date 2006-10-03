Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWJCBsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWJCBsv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 21:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWJCBsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 21:48:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030237AbWJCBss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 21:48:48 -0400
Date: Mon, 2 Oct 2006 18:48:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, s270-linux@mail.0pointer.de
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support
Message-Id: <20061002184840.e5c090f2.akpm@osdl.org>
In-Reply-To: <20061003011056.GA28731@ecstasy.ring2.lan>
References: <20061003011056.GA28731@ecstasy.ring2.lan>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 03:10:56 +0200
Lennart Poettering <mzxreary@0pointer.de> wrote:

> From: Lennart Poettering <mzxreary@0pointer.de>
> 
> A driver for the special features of MSI S270 laptops (and maybe other
> MSI laptops). This driver implements a backlight device for
> controlling LCD brightness (/sys/class/backlight/msi-laptop-bl/).  In
> addition it allows access to the WLAN and Bluetooth states through a
> platform driver (/sys/devices/platform/msi-laptop-pf/).
> 
> ...
>

err, this driver has only about fifteen tab characters in it.  The whole
thing is using lean-on-the-spacebar instead of hard tabs.

fix, please??

> +static ssize_t store_lcd_level(
> +                struct device *dev, struct device_attribute *attr, const char *buf, size_t count) {

No, kernel-style is

static ssize_t store_lcd_level(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t count)
{

or thereabouts.



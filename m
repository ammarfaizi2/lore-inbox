Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWHUW6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWHUW6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWHUW6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:58:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751297AbWHUW6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:58:51 -0400
Date: Mon, 21 Aug 2006 15:58:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, rubini@vision.unipv.it, pavel@suse.cz,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support, third try
Message-Id: <20060821155831.daa8425e.akpm@osdl.org>
In-Reply-To: <20060820225209.GA5453@curacao>
References: <20060820225209.GA5453@curacao>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 00:52:09 +0200
Lennart Poettering <mzxreary@0pointer.de> wrote:

> +static ssize_t store_auto_brightness(
> +        struct device *dev,
> +        struct device_attribute *attr,
> +        const char *buf, size_t count) {
> +        
> +        int enable, ret;

Please follow the usual kernel coding style, which would yield something like:

static ssize_t store_auto_brightness(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t count)
{
        int enable, ret;

(affects entire patch).

And please also prepare and maintain a standalone changelog.  The one you have here
is full of references to some long-gone email.  Think: "how will my changelog look
when it is in the main git tree".

Thanks.

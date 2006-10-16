Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161022AbWJPRr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161022AbWJPRr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 13:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbWJPRr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 13:47:27 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:6376 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1161022AbWJPRr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 13:47:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rzrs556PnaUwOvpEHdH5/aw+0Ox0TGu6DpSDm5K4bovWBdeQWF4vQ+d7l4yBYqp0Te9X+TLOB9vaTdKIV5zeYTqzC3pADhHCwE7MXc9d9fHi6FIMuuA73aeiDKMmjMK4r4RdVCiYEYP3c00hF3jRUqfbcAIxV5fRCnX0guCw/d4=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Matt Domsch <Matt_Domsch@dell.com>, len.brown@intel.com
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Tue, 17 Oct 2006 01:45:03 +0800
User-Agent: KMail/1.8.2
Cc: Richard Hughes <hughsient@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061010161012.GA18847@lists.us.dell.com> <200610120028.29617.luming.yu@gmail.com>
In-Reply-To: <200610120028.29617.luming.yu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610170145.03779.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > a generic ACPI driver that exports the _BCL and _BCM method
> > implementations via that same interface, so that systems providing
> > that will "just work".  drivers/acpi/video.c currently exports this
> > via /proc/acpi/video/$DEVICE/brightness, which isn't the same as
> > /sys/class/backlight. :-(
>
> Yes, I'm working on acpi video driver transition , and have posted a patch
> to user backlight for acpi video driver.
> http://marc.theaimsgroup.com/?l=linux-acpi&m=115574087203605&w=2

Just updated the backlight and output sysfs support for ACPI Video driver on
bugzilla. If you are interested this, please take a look at
http://bugzilla.kernel.org/show_bug.cgi?id=5749#c18

signed-off-by 	Luming.yu@gmail.com

[patch 1/3] vidoe sysfs support: Add dev argument for baclight sys dev
[patch 2/3] Add display output class support
[patch 3/3] backlight and output sysfs support for acpi video driver

Thanks,
Luming

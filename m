Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758430AbWLFANn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbWLFANn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758543AbWLFANn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:13:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55713 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758430AbWLFANm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:13:42 -0500
Date: Tue, 5 Dec 2006 16:13:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061205161339.29428b4e.akpm@osdl.org>
In-Reply-To: <20061206005529.30f07859.alessandro.guido@gmail.com>
References: <20061206005529.30f07859.alessandro.guido@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 00:55:29 +0100
Alessandro Guido <alessandro.guido@gmail.com> wrote:

> Sorry, I didn't find in your list the patches regarding the sony_acpi
> driver that were present in 2.6.19-rc6-mm2. I'm talking about:
> 
> 2.6-sony_acpi4.patch
> sony_apci-resume.patch
> acpi-add-backlight-support-to-the-sony_acpi.patch
> acpi-add-backlight-support-to-the-sony_acpi-v2.patch
> 
> What is the future of these?
> 

I spose I need to talk Len into merging the sony-acpi driver.

Before that I need to work out why /sys/class/backlight/sony/brightness
magically vanished on me after a suspend-to-ram operation.

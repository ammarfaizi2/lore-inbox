Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWJJVXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWJJVXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWJJVXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:23:55 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:14977 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030429AbWJJVXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:23:53 -0400
Date: Tue, 10 Oct 2006 22:23:41 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Yu Luming <luming.yu@gmail.com>
Cc: Alessandro Guido <alessandro.guido@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, len.brown@intel.com,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061010212341.GA31972@srcf.ucam.org>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org> <20061002132549.9d164061.alessandro.guido@gmail.com> <200610102317.24310.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610102317.24310.luming.yu@gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 11:17:23PM +0800, Yu Luming wrote:

> Also, we need to make hot-key events  have similar handling code .
> For example, Fn+F5 and Fn+F6 are brightness down and up key on my sony laptop.  
> There is a driver called sonypi.c can map Fn+F5/F6 to KEY_FN_F5/F6. But I 
> think It should be mapped to KEY_BRIGHTNESSDOWN/UP (linux/input.h)
> Although, sonypi.c is NOT so clean, but , if it can report right event to 
> input layer for all sony laptop(it works for me), and all related functions 
> can be controlled through generic sysfs interface, then I would say sony has 
> the best hot-key solution I have even seen so far for linux.

It would have to be DMI-based to some extent - not all Sonys use the 
same keys for the same purpose. Misery ensues.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

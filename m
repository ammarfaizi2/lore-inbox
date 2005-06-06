Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVFFGZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFFGZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 02:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFFGZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 02:25:10 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:21180 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261189AbVFFGZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 02:25:03 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Adam Morley <adam.morley@gmail.com>
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Date: Mon, 6 Jun 2005 01:25:00 -0500
User-Agent: KMail/1.8.1
References: <b70d73800506051924546c8931@mail.gmail.com>
In-Reply-To: <b70d73800506051924546c8931@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506060125.00489.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 June 2005 21:24, Adam Morley wrote:
 > When I do a mem suspend (echo mem > /sys/power/state), either through
> a lid switch ACPI action, or manually echo'ing the parameter, the
> mouse doesn't work after un-suspending.  It seems like it is no longer
> detected/initialized.  cat'ing the device file doesn't produce output,
> and gpm and X don't get mouse inputs.

Could you please try booting 2.6.12-rc5 with "i8042.debug" on the kernel
command line; suspend, resume and post your dmesg?

Thanks!
 
-- 
Dmitry

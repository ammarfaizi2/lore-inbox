Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUGKScm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUGKScm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 14:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUGKScm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 14:32:42 -0400
Received: from imap.gmx.net ([213.165.64.20]:22440 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266646AbUGKSch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 14:32:37 -0400
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
Reply-To: warpy@gmx.de
To: Len Brown <len.brown@intel.com>
Subject: Re: 2.6.7-mm7
Date: Sun, 11 Jul 2004 20:32:38 +0200
User-Agent: KMail/1.6.2
References: <A6974D8E5F98D511BB910002A50A6647615FFA5D@hdsmsx403.hd.intel.com> <1089513248.32038.46.camel@dhcppc2>
In-Reply-To: <1089513248.32038.46.camel@dhcppc2>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407112032.38215.warpy@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 11. Juli 2004 04:34 schrieben Sie:

> When you revert bk-acpi.patch shutdown works?

Without bk-acpi.patch it works.

> did it work in stock 2.6.7?

Stock 2.6.7  it's ok.

> If yes, does it work with stock 2.6.7 + bk-acpi.patch?
>
> any change if you boot latest -mm with "acpi_os_name=Linux"?

yep it works too.

Without "acpi_os_name=Linux" in 2.6.7-mm7 i get 
acpi_power_off called
hwsleep-0312 [46] acpi_enter_sleep_state: Entering sleep state [S5]

-- 
Michael Geithe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbSKSUJn>; Tue, 19 Nov 2002 15:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267136AbSKSUJn>; Tue, 19 Nov 2002 15:09:43 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:42735 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S267125AbSKSUJm>; Tue, 19 Nov 2002 15:09:42 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A521@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Bob Miller'" <rem@osdl.org>, trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: RE: [TRIVIAL PATCH 2.5.48] Remove compile warning from drivers/ac
	pi/bus.c
Date: Tue, 19 Nov 2002 12:15:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bob Miller [mailto:rem@osdl.org] 
> Add the include of linux/device.h to remove a compile time waring
> from drivers/acpi/bus.c
> 
> 
> diff -Nru a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> --- a/drivers/acpi/bus.c	Tue Nov 19 10:31:17 2002
> +++ b/drivers/acpi/bus.c	Tue Nov 19 10:31:17 2002
> @@ -29,6 +29,7 @@
>  #include <linux/pm.h>
>  #include <linux/device.h>
>  #include <linux/proc_fs.h>
> +#include <linux/device.h>

Already fixed. Look 2 lines up. :)

As for all the other ACPI unused variable warnings, they go away when debug
output is turned off.

Regards -- Andy

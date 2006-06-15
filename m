Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWFNXZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWFNXZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWFNXZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:25:48 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:25222 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965026AbWFNXZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:25:47 -0400
Message-ID: <4490A92F.5010604@oracle.com>
Date: Wed, 14 Jun 2006 17:26:23 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Voluspa <lista1@comhem.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
References: <20060615010850.3d375fa9.lista1@comhem.se>
In-Reply-To: <20060615010850.3d375fa9.lista1@comhem.se>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:
>   CC      drivers/acpi/glue.o
>   CC      drivers/acpi/ec.o
> drivers/acpi/ec.c: In function `acpi_ec_poll_read':
> drivers/acpi/ec.c:341: error: union has no member named `polling'
> drivers/acpi/ec.c:363: error: union has no member named `polling'
> drivers/acpi/ec.c: In function `acpi_ec_poll_write':
> drivers/acpi/ec.c:390: error: union has no member named `polling'
> drivers/acpi/ec.c:415: error: union has no member named `polling'
> drivers/acpi/ec.c:376: warning: unused variable `flags'
> drivers/acpi/ec.c: In function `acpi_ec_poll_query':
> drivers/acpi/ec.c:599: error: union has no member named `polling'
> drivers/acpi/ec.c:615: error: union has no member named `polling'
> drivers/acpi/ec.c:578: warning: unused variable `flags'
> drivers/acpi/ec.c: In function `acpi_ec_gpe_poll_query':
> drivers/acpi/ec.c:705: error: union has no member named `polling'
> drivers/acpi/ec.c:708: error: union has no member named `polling'
> drivers/acpi/ec.c:694: warning: unused variable `flags'
> drivers/acpi/ec.c: In function `acpi_ec_poll_add':
> drivers/acpi/ec.c:1020: error: union has no member named `polling'
> drivers/acpi/ec.c: In function `acpi_fake_ecdt_poll_callback':
> drivers/acpi/ec.c:1315: error: union has no member named `polling'
> drivers/acpi/ec.c: In function `acpi_ec_poll_get_real_ecdt':
> drivers/acpi/ec.c:1431: error: union has no member named `polling'
> make[2]: *** [drivers/acpi/ec.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2

Thanks, I'll work on that.

~Randy



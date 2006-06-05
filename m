Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750809AbWFEI70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWFEI70 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWFEI70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:59:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750809AbWFEI7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:59:25 -0400
Date: Mon, 5 Jun 2006 01:59:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3 -- ACPI errors (are these ones that are
 significant?)
Message-Id: <20060605015922.0defacbc.akpm@osdl.org>
In-Reply-To: <a44ae5cd0606050124h4c82f45aq27f68f9d07956642@mail.gmail.com>
References: <a44ae5cd0606050124h4c82f45aq27f68f9d07956642@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 01:24:27 -0700
"Miles Lane" <miles.lane@gmail.com> wrote:

> During boot:
> 
> acpi_processor-0731 [00] processor_preregister_: Error while parsing
> _PSD domain information. Assuming no coordination
> 
> During resume and after the "BUG: sleeping function called from
> invalid context at include/asm/semaphore.h:99 in_atomic():0,
> irqs_disabled():1" that I reported earlier:
> 
> PM: Finishing wakeup.
>  acpi: resuming
> ACPI: read EC, IB not empty
> ACPI: read EC, OB not full
> ACPI Exception (evregion-0412): AE_TIME, Returned by Handler for
> [EmbeddedControl] [20060310]
> ACPI Exception (dswexec-0459): AE_TIME, While resolving operands for
> [Store] [20060310]
> ACPI Error (psparse-0522): Method parse/execution failed
> [\_TZ_.THRM._TMP] (Node c189ec44), AE_TIME
> agpgart-intel 0000:00:00.0: resuming

Please copy linux-acpi on acpi-related problems.

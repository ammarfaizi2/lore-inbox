Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751748AbWG0Qou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbWG0Qou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 12:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWG0Qou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 12:44:50 -0400
Received: from xenotime.net ([66.160.160.81]:33452 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751744AbWG0Qot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 12:44:49 -0400
Date: Thu, 27 Jul 2006 09:44:46 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: "jens m. noedler" <noedler@web.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update kernel-parameters.txt
In-Reply-To: <44C8CDF7.4070205@web.de>
Message-ID: <Pine.LNX.4.58.0607270942180.7955@shark.he.net>
References: <44C8CDF7.4070205@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, jens m. noedler wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi,
>
> This is just a little documentation update which applies to 2.6.18-rc2.
>
> Signed-off-by: jens m. noedler <noedler@web.de>
>
> - ---
>
> - --- Documentation/kernel-parameters.txt.orig    2006-07-26 16:47:34.000000000 +0200
> +++ Documentation/kernel-parameters.txt 2006-07-27 15:57:02.000000000 +0200

Patch should apply with 'patch -p1' (i.e., filenames begin with linux/
or a/, b/ etc.)

> @@ -110,6 +110,13 @@ be entered as an environment variable, w
>  it will appear as a kernel argument readable via /proc/cmdline by programs
>  running once the system is up.
>
> +The number of kernel parameters in not limited, but the length of the
                                   is

> +complete command line (parameters including spaces etc.) is limited to
> +a fixed number of characters. This limit depends on the architecture
> +and is between 256 and 4096 characters. It is defined in the file
> +./include/asm/setup.h as COMMAND_LINE_SIZE.
> +
> +
>         53c7xx=         [HW,SCSI] Amiga SCSI controllers
>                         See header of drivers/scsi/53c7xx.c.
>                         See also Documentation/scsi/ncr53c7xx.txt.

-- 
~Randy

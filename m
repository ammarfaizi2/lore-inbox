Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSA3A4n>; Tue, 29 Jan 2002 19:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286263AbSA3A4d>; Tue, 29 Jan 2002 19:56:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49929 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285589AbSA3A4W>;
	Tue, 29 Jan 2002 19:56:22 -0500
Message-ID: <3C57430B.8B6DFD9F@zip.com.au>
Date: Tue, 29 Jan 2002 16:49:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6
In-Reply-To: Your message of "Tue, 29 Jan 2002 14:21:50 -0800."
	             <3C57207E.28598C1F@zip.com.au> <E16VivB-0005sI-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> @@ -316,6 +341,7 @@
>         lock_kernel();
>         printk(linux_banner);
>         setup_arch(&command_line);
> +       setup_per_cpu_areas();
>         printk("Kernel command line: %s\n", saved_command_line);
>         parse_options(command_line);
>         trap_init();

Looks good.  I'll shut up now.

-

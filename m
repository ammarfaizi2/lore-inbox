Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313261AbSDTXyI>; Sat, 20 Apr 2002 19:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313288AbSDTXyH>; Sat, 20 Apr 2002 19:54:07 -0400
Received: from bazooka.saturnus.vein.hu ([193.6.40.86]:9856 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S313261AbSDTXyG>; Sat, 20 Apr 2002 19:54:06 -0400
Date: Sun, 21 Apr 2002 01:54:04 +0200
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre7-ac2 ACPI compile failure
Message-ID: <20020421015404.A501@bazooka.saturnus.vein.hu>
In-Reply-To: <3CC1EC30.7020902@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
From: Banai Zoltan <bazooka@emitel.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 10:31:12PM +0000, Sid Boyce wrote:
> drivers/acpi/acpi.o: In function `sm_osl_proc_write_sleep':
> drivers/acpi/acpi.o(.text+0x2bba1): undefined reference to 
> `software_suspend'
> make: *** [vmlinux] Error 1
> 
I got the same failure.
Addig CONFIG_SOFTWARE_SUSPEND = y seems to work.

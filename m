Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289761AbSBJVcs>; Sun, 10 Feb 2002 16:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSBJVbK>; Sun, 10 Feb 2002 16:31:10 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:48138 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289761AbSBJVaj>;
	Sun, 10 Feb 2002 16:30:39 -0500
Date: Sat, 9 Feb 2002 21:13:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Serial Development <linux-serial@vger.kernel.org>
Subject: Re: CONFIG_SERIAL_ACPI and early_serial_setup
Message-ID: <20020209201333.GB851@elf.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0202081320200.29963-100000@vervain.sonytel.be> <20020208134311.D32413@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020208134311.D32413@suse.de>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > If CONFIG_SERIAL_ACPI=y, but CONFIG_SERIAL=m, the kernel (2.4.18-pre9) doesn't
>  > link because early_serial_setup() is not found.
>  > 
>  > I think the correct fix is to not allow CONFIG_SERIAL_ACPI, unless
>  > CONFIG_SERIAL=y.
> 
>  Isn't CONFIG_SERIAL_ACPI an ia64 only option ?

No, AFAIK.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291441AbSBHMnc>; Fri, 8 Feb 2002 07:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291247AbSBHMnX>; Fri, 8 Feb 2002 07:43:23 -0500
Received: from ns.suse.de ([213.95.15.193]:46093 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291033AbSBHMnP>;
	Fri, 8 Feb 2002 07:43:15 -0500
Date: Fri, 8 Feb 2002 13:43:12 +0100
From: Dave Jones <davej@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Serial Development <linux-serial@vger.kernel.org>
Subject: Re: CONFIG_SERIAL_ACPI and early_serial_setup
Message-ID: <20020208134311.D32413@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux Serial Development <linux-serial@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0202081320200.29963-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0202081320200.29963-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Fri, Feb 08, 2002 at 01:25:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 01:25:07PM +0100, Geert Uytterhoeven wrote:
 > 
 > If CONFIG_SERIAL_ACPI=y, but CONFIG_SERIAL=m, the kernel (2.4.18-pre9) doesn't
 > link because early_serial_setup() is not found.
 > 
 > I think the correct fix is to not allow CONFIG_SERIAL_ACPI, unless
 > CONFIG_SERIAL=y.

 Isn't CONFIG_SERIAL_ACPI an ia64 only option ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

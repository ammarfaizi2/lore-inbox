Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTBXMXE>; Mon, 24 Feb 2003 07:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbTBXMXD>; Mon, 24 Feb 2003 07:23:03 -0500
Received: from cust.95.184.adsl.cistron.nl ([195.64.95.184]:33664 "EHLO ileva")
	by vger.kernel.org with ESMTP id <S267029AbTBXMXC>;
	Mon, 24 Feb 2003 07:23:02 -0500
Date: Mon, 24 Feb 2003 13:33:05 +0100
From: Floris Kraak <floris@snow.nl>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Meino Christian Cramer <mccramer@s.netic.de>, wli@holomorphy.com,
       efraim@clues.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.62 fails to boot, Uncompressing... and then nothing
Message-ID: <20030224123305.GA4323@blackstar.nl>
References: <20030219071932.GA3746@clues.de> <20030219073221.GR29983@holomorphy.com> <20030219.095905.92587466.mccramer@s.netic.de> <200302191052.47663.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302191052.47663.baldrick@wanadoo.fr>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Feb 19, 2003 at 10:52:47AM +0100, Duncan Sands wrote:
> This is becoming a FAQ!  Did you enable the console in your .config?
> 
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> 
[snip]
> 
> I hope this helps,
> 

Hi, I'd like to pipe in with another report of 2.5.62 not booting.
I _do_ have these lines in my .config and 2.4.19 boots easily while
2.5.62 does not. In fact, neither does 2.5.61.

2.5.59 (with a virtually identical .config) boots fine, but when I
reboot 2.4.19 suddenly doesn't boot (just once, though). If I turn the
machine off and back on that problem goes away. I am not sure if it
is related.

I am not using ACPI. I am using APM. The system is a Dell Inspiron
8200 with a 1.4 Ghz Mobile P4. The bootloader is lilo. Any other
information I'd be glad to give, but debugging is hard because the
kernel doesn't even get to the stage where it prints out it's own
version number.

Regards,
Floris Kraak
-- 
 "If you continue using Windows your system may become unstable."
	-- Windows 95 BSOD

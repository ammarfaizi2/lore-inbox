Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLNT4i>; Thu, 14 Dec 2000 14:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbQLNT42>; Thu, 14 Dec 2000 14:56:28 -0500
Received: from chicago.cheek.com ([207.202.196.154]:29703 "EHLO
	chicago.cheek.com") by vger.kernel.org with ESMTP
	id <S129267AbQLNT4M>; Thu, 14 Dec 2000 14:56:12 -0500
Message-ID: <3A391E9F.CAF42006@cheek.com>
Date: Thu, 14 Dec 2000 11:25:19 -0800
From: Joseph Cheek <joseph@cheek.com>
Organization: LinuxCare, Inc.
X-Mailer: Mozilla 4.72C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.2.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: test12 + initrd = swapper at 99.8% CPU time
In-Reply-To: <200012141246.eBECkoc06148@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

ps axufw shows it as pid 1.

Russell King wrote:

> Joseph Cheek writes:
> > i'm using test12 to perform a clean linux install.  as soon as i get to
> > a command prompt, ps axufw shows swapper at 99.8% CPU usage.  this
> > didn't repro with test11, and doesn't repro if i don't use an initrd.
>
> What pid does this task have?  The only process that should be "swapper"
> is pid0, and pid0 should be hidden from view.
>
> If its not pid0, then I'd guess that it may be a rogue program...
>    _____
>   |_____| ------------------------------------------------- ---+---+-
>   |   |         Russell King        rmk@arm.linux.org.uk      --- ---
>   | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
>   | +-+-+                                                     --- -+-
>   /   |               THE developer of ARM Linux              |+| /|\
>  /  | | |                                                     ---  |
>     +-+-+ -------------------------------------------------  /\\\  |

--
thanks!

joe

--
Joseph Cheek, Sr Linux Consultant, Linuxcare | http://www.linuxcare.com/
Linuxcare.  Support for the Revolution.      | joseph@linuxcare.com
CTO / Acting PM, Redmond Linux Project       | joseph@redmondlinux.org
425 990-1072 vox [1074 fax] 206 679-6838 pcs | joseph@cheek.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

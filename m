Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRIARL6>; Sat, 1 Sep 2001 13:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270827AbRIARLi>; Sat, 1 Sep 2001 13:11:38 -0400
Received: from femail29.sdc1.sfba.home.com ([24.254.60.19]:7141 "EHLO
	femail29.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270825AbRIARLg>; Sat, 1 Sep 2001 13:11:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: "Simen Thoresen" <simentt@dolphinics.no>,
        "alan" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Status of the VIA KT133a and 2.4.x debacle?
Date: Sat, 1 Sep 2001 10:11:14 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109011619480531.23AA844A@scispor.dolphinics.no>
In-Reply-To: <200109011619480531.23AA844A@scispor.dolphinics.no>
MIME-Version: 1.0
Message-Id: <01090110111400.00171@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 September 2001 07:19 am, Simen Thoresen wrote:
> Alan, list, et all,
>
> I've picked up a KT133a board (EpoX 8KTA/3) and a 1.2GHz Thunderbird
> processor (133MHz FSB), and have seen the same problems that have been
> reported previously with the KT133a. Random oops'es, both fatal and non
> fatal, when running the system on a 2.4 kernel with CONFIG_MK7.
>
> The bord seems rock solid with 2.2.x kernels, and also with 2.4.x
> kernels with CONFIG_M686 set for basic i686 + MMX. I've also run the
> board with a 100MHz FSB, but that has not improved anything. Also
> turning off /some/ optimizations in bios have not helped.

Just out of curiosity, can you drop that to 100Mhz FSB and a multiplier 
of 8? I don't know about the manual clocking support on EpoX boards, but 
if you can, it might be good to give it a shot. Most likely it has 
nothing to do with clock speed whatsoever, but I'm really beginning to 
wonder. I don't think I've seen a single reported case under 900-1000Mhz, 
and thunderbirds were made below 900Mhz.

(reason I chose 800MHz is my non-tbird Athlon is 800 and is rock solid)

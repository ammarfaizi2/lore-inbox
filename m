Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130133AbQKPPJU>; Thu, 16 Nov 2000 10:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130645AbQKPPJA>; Thu, 16 Nov 2000 10:09:00 -0500
Received: from styx.suse.cz ([195.70.145.226]:63470 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S130133AbQKPPIF>;
	Thu, 16 Nov 2000 10:08:05 -0500
Date: Thu, 16 Nov 2000 12:00:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: barryn@pobox.com
Cc: linux-kernel@vger.kernel.org, hahn@coffee.psychology.mcmaster.ca
Subject: Re: [BUG?] AMD 5x86 and 2.4 (was Re: [BUG?] AMD K5 and 2.4)
Message-ID: <20001116120019.B665@suse.cz>
In-Reply-To: <200011150435.UAA05562@cx518206-b.irvn1.occa.home.com> <200011151958.LAA09896@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011151958.LAA09896@cx518206-b.irvn1.occa.home.com>; from barryn@cx518206-b.irvn1.occa.home.com on Wed, Nov 15, 2000 at 11:58:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2000 at 11:58:27AM -0800, Barry K. Nathan wrote:
> It looks like I was mistaken in my original message. I have an AMD 5x86, not
> a K5.
> 
> Nevertheless, menuconfig lists the 586 option as "586/K5/5x86/6x86/6x86MX".
> But, it fails to boot on my 5x86 and I have to compile for a 486 (for 2.4).
> As I mentioned in my previous message, the 586/... option boots with 2.2.
> 
> I just noticed that, under both 2.2 and 2.4, uname -a identifies the
> machine as an i486.
> 
> Should the 486 option be changed to "486/5x86" and the 586/... option
> changed to "586/K5/6x86/6x86MX"? Or is there a bug here that needs fixing?
> (IIRC, Cyrix and IBM made 5x86's as well - are those more like fast 486's
> or slow Pentiums? I don't remember. If they're like Pentiums, perhaps
> "486/AMD 5x86" and "586/non-AMD 5x86/6x86/6x86MX"...?)

If I recall correctly:

Am5x86 == AMD X5 == a very fast 486 processor with a big WB cache
Cx5x86 == IBM 5x86 == a slow Pentium-like processor in a 486 socket

So yes, for the AMD 5x86 you have to select '486'.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUI0IZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUI0IZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 04:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUI0IZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 04:25:52 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:50190 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S266250AbUI0IZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 04:25:38 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: external modules documentation
Date: Mon, 27 Sep 2004 10:25:32 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040918112900.GA22428@lst.de> <200409232224.50234.arekm@pld-linux.org> <20040927072549.GC8613@mars.ravnborg.org>
In-Reply-To: <20040927072549.GC8613@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409271025.32130.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 of September 2004 09:25, Sam Ravnborg wrote:

> > Tthis means that one, unmodified source tree is _not_ usable for multiple
> > architectures. You can't use the same, prepared sources and for example
> > create noarch.rpm or burn on cd and then use for external modules
> > building on different architectures.
>
> You are doing it wrong.
> You need in your case one source tree, several output dirs.
> So use
> make ARCH=sparc CROSS_COMPILE=xxx O=~/build/sparc ...
>
> make ARCH=ppc CROSS_COMPILE=xxx O=~/build/ppc ...
cross_compile? I don't want to make cross compilation. I want to use the same 
source on my x86 machine, ppc machine, alpha machine, sparc machine and so 
on. Since make in external modules dir doesn't create scripts and such kbuild 
stuff I don't see how this can work with make modules_prepare.

Please explain.

>  Sam

-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/

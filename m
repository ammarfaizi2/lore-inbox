Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271592AbRH0CQY>; Sun, 26 Aug 2001 22:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271635AbRH0CQN>; Sun, 26 Aug 2001 22:16:13 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:56210
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S271592AbRH0CQF>; Sun, 26 Aug 2001 22:16:05 -0400
Date: Sun, 26 Aug 2001 19:15:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac12 ppc ftr_fixup
Message-ID: <20010826191536.C1481@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <19943.998872042@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19943.998872042@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2001 at 10:27:22AM +1000, Keith Owens wrote:

> 2.4.9-ac12 has new ppc code for CPU feature fixups.  The ftr_fixup code
> only handles entries that are built into the kernel.  timex.h defines
> get_cycles() using ftr_fixup and get_cycles() is used all over the
> place, including in modules.  AFAICT we need to add modutils support
> for ftr_fixup.

Er, eh?  Excuse me if I'm being obtuse, but where is the problem?  The fixup
stuff is closely tied to bootup and what processor we happen to be on
at the time.  So we won't be trying to fixup any code in a module...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

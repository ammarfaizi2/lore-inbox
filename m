Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266929AbRGHREt>; Sun, 8 Jul 2001 13:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266927AbRGHREj>; Sun, 8 Jul 2001 13:04:39 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:17026 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266932AbRGHRE3>;
	Sun, 8 Jul 2001 13:04:29 -0400
Date: Mon, 9 Jul 2001 05:04:18 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Dave Jones <davej@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vibol Hou <vhou@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)
Message-ID: <20010709050418.A28809@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.30.0107081733320.28660-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0107081733320.28660-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Jul 08, 2001 at 05:33:59PM +0200, Dave Jones wrote:

    Actually you merged that with Linus a few revisions back iirc.

I don't see it for K7/AMD:

cw:tty5@tapu(kernel)$ pwd
/home/cw/wk/linux/linux-2.4.7-pre2+O_DIRECT/arch/i386/kernel

cw:tty5@tapu(kernel)$ grep machine_check\(struct\ pt bluesmoke.c
static void intel_machine_check(struct pt_regs * regs, long error_code)
static void pentium_machine_check(struct pt_regs * regs, long error_code)
static void winchip_machine_check(struct pt_regs * regs, long error_code)
static void unexpected_machine_check(struct pt_regs * regs, long error_code)
void do_machine_check(struct pt_regs * regs, long error_code)




  --cw

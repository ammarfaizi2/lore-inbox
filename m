Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTKUEYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 23:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTKUEYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 23:24:17 -0500
Received: from mx2.undergrid.net ([64.174.245.170]:59010 "EHLO
	mail.undergrid.net") by vger.kernel.org with ESMTP id S262844AbTKUEYQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 23:24:16 -0500
From: "Jeremy T. Bouse" <Jeremy.Bouse@UnderGrid.net>
Date: Thu, 20 Nov 2003 20:11:13 -0800
To: linux-kernel@vger.kernel.org
Cc: Buck Rekow <rekow@bigskytel.com>, breed@users.sourceforge.net,
       achirica@users.sourceforge.net
Subject: Re: PROBLEM: Aironet compile failure 2.6-test9/Alpha architecture
Message-ID: <20031121041113.GB15436@UnderGrid.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Buck Rekow <rekow@bigskytel.com>, breed@users.sourceforge.net,
	achirica@users.sourceforge.net
References: <3FBD67E7.5020405@bigskytel.com> <20031121032216.GA12185@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031121032216.GA12185@twiddle.net>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-GPG-Debian: 1024D/29AB4CDD  C745 FA35 27B4 32A6 91B3 3935 D573 D5B1 29AB 4CDD
X-GPG-General: 1024D/62DBDF62  E636 AB22 DC87 CD52 A3A4 D809 544C 4868 62DB DF62
User-Agent: Mutt/1.5.4i
X-UnderGrid-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 07:22:16PM -0800, Richard Henderson wrote:
> On Thu, Nov 20, 2003 at 06:18:31PM -0700, Buck Rekow wrote:
> > drivers/net/wireless/airo.c: In function `emmh32_setseed':
> > drivers/net/wireless/airo.c:1458: internal error--unrecognizable insn:
> > (insn:TI 512 478 513 (set (reg:DI 1 $1)
> >        (plus:DI (reg:DI 30 $30)
> >            (const_int 4398046511104 [0x40000000000]))) -1 (insn_list 51 
> > (insn_list:REG_DEP_ANTI 494 (nil)))
> >    (nil))
> 
> This is always a compiler bug.
> 
> > Gnu C                  2.95.4
> 
> File a bug with Debian if you want, but the GCC folk proper
> aren't even going to look at something this old.
> 
	Being a Debian Developer this must be being built on Woody 3.0 which
is the current stable release. Sarge the current testing and Sid the
unstable distros both have 3.2 or 3.3 default...

	Regards,
	Jeremy

> 
> r~
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWGQNiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWGQNiL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 09:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWGQNiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 09:38:11 -0400
Received: from mail.gmx.de ([213.165.64.21]:2737 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750775AbWGQNiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 09:38:10 -0400
Cc: johnstul@us.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Valdis.Kletnieks@vt.edu
Content-Type: text/plain; charset="utf-8"
Date: Mon, 17 Jul 2006 15:38:09 +0200
From: "Uwe Bugla" <uwe.bugla@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0607171242440.6761@scrub.home>
Message-ID: <20060717133809.150390@gmx.net>
MIME-Version: 1.0
References: <20060714150418.120680@gmx.net>
 <Pine.LNX.4.64.0607171242440.6761@scrub.home>
Subject: Re: Re: i686 hang on boot in userspace
To: Roman Zippel <zippel@linux-m68k.org>
X-Authenticated: #8359428
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-------- Original-Nachricht --------
Datum: Mon, 17 Jul 2006 12:52:28 +0200 (CEST)
Von: Roman Zippel <zippel@linux-m68k.org>
An: Uwe Bugla <uwe.bugla@gmx.de>
Betreff: Re: i686 hang on boot in userspace

> Hi,
> 
> On Fri, 14 Jul 2006, Uwe Bugla wrote:
> 
> > Hi everybody,
> > first of all thanks to the explanatory hints how a magic Sysrq key works
> – I've learned a lot.
> > 
> > I first pressed ALT + PrintScreen + P, then ALT + PrintScreen + T.
> > To avoid wordwrapping or other unwanted effects please see the resulting
> kern.log as outline attachment.
> > 
> > Could someone please explain to me what's behind that cryptic code?
> 
> It shows what the kernel is currently is doing and where it's spending the
> time.
> First, your kernel buffer log buffer seems a little small, so not 
> everything is captured. Could you increase the number in the "Kernel log 
> buffer size" option (it's in the "Kernel debugging" part of the "Kernel 
> hacking" menu).
> Second, could you press ALT+PrintScreen+P a few more times (maybe around 
> 10 at least) while the kernel hangs? This would should where the cpu is 
> spending its time and whether it's at a single place or at different 
> places.
> Thanks.
> 
> bye, Roman

Hi Roman, Hi everybody else,
my boot problem is solved within kernel 2.6.18-rc1-mm2!!!

A thousands of thanks for all your efforts!

I have compared 18-rc1-mm1 and 18-rc1-mm2.
mm2 contains a patch for timer.c owning almost twice as many hunks than mm1.
In so far I was sure it was a timer.c issue.

Regards

Uwe

-- 


Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl

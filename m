Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318368AbSHKVAV>; Sun, 11 Aug 2002 17:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318365AbSHKVAV>; Sun, 11 Aug 2002 17:00:21 -0400
Received: from codepoet.org ([166.70.99.138]:18148 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318368AbSHKVAU>;
	Sun, 11 Aug 2002 17:00:20 -0400
Date: Sun, 11 Aug 2002 15:04:06 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Rob Landley <landley@trommello.org>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Oliver Xymoron <oxymoron@waste.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: klibc development release
Message-ID: <20020811210406.GA27048@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rob Landley <landley@trommello.org>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Oliver Xymoron <oxymoron@waste.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200208111820.g7BIKPd172856@saturn.cs.uml.edu> <200208112031.g7BKVHQ209420@pimout1-ext.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208112031.g7BKVHQ209420@pimout1-ext.prodigy.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Aug 11, 2002 at 11:31:13AM -0400, Rob Landley wrote:
> Personally, I question the klibc work a bit because it's reinventing the 
> wheel with projects like uclibc already mostly there.  But Al pointed out the 
> license issue with static linking against LGPL libraries, and in any case a 

Keep in mind that you _can_ staticly link even closed source
stuff against an LGPL library...  You just need to "Accompany the
work with a written offer, valid for at least three years" to
provide users with an object file that can be re-linked against
newer versions of the LGPL library.  Or simply provide the .o
file.  See the LGPL Section 6...

> to one side: I'm not fond of glibc and am looking to replace it in my own 
> system, but it hasn't made it to the top of my to-do list yet.  (Dietlibc is 
> straight GPL: it can't even be the dynamic replacement for glibc in a real 
> world linux distribution.  HPA suggested I look at newlibc, which I've added 
> to my to-do list).

As far as I know, uClibc is the only library that is able to
replace glibc for real world linux distributions...  And I've
looked long and hard (which was why I ended up making uClibc),

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

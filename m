Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272627AbTG1DFu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 23:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272649AbTG1DFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 23:05:50 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:32930 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S272627AbTG1DFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 23:05:49 -0400
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Otto Solares <solca@guug.org>, "J.A. Magallon" <jamagallon@able.es>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ihar Philips Filipau <filia@softhome.net>
Subject: Re: Kernel 2.6 size increase - get_current()?
References: <9CA735B0-BEAD-11D7-BEDE-000A95A0560C@us.ibm.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 28 Jul 2003 12:19:13 +0900
In-Reply-To: <9CA735B0-BEAD-11D7-BEDE-000A95A0560C@us.ibm.com>
Message-ID: <buowue3l4ni.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hollis Blanchard <hollisb@us.ibm.com> writes:
> Inlines don't always help performance (depending on cache sizes, branch 
> penalties, frequency of code access...), but they do always increase 
> code size.

Um, inlining can often _decrease_ code size because it gives the
compiler substantial new opportunities for optimization (the function
body is no longer opaque, so the compiler has a lot more info, and any
optimizations done on the inlined body can be context-specific).

-Miles
-- 
Is it true that nothing can be known?  If so how do we know this?  -Woody Allen

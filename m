Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTJWAM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 20:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJWAM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 20:12:29 -0400
Received: from main.gmane.org ([80.91.224.249]:14055 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261235AbTJWAM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 20:12:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86
 Architecture
Date: Thu, 23 Oct 2003 02:12:25 +0200
Message-ID: <yw1xn0bsq0ba.fsf@kth.se>
References: <200310221855.15925.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:CJUV1F8JBy9SBCLH46sA6z5NX6A=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joseph D. Wagner" <theman@josephdwagner.info> writes:

> Yes, I know you can select Pentium III, Pentium 4, Athlon, etc, under 
> processor type when doing a 'make xconfig', but those selections do not 
> translate into the appropriate -mcpu and -march flags.

In Linux 2.6.0-test8, the flags are correct.  Which version are you
referring to?

> I don't want to have to hand edit the makefiles just to optimize my kernel.  
> I think this change is simple enough to do, and would allow kernel 
> developers the option of processor-specific optimizations in the future.

Considered the time normally spent in the kernel, a few percent faster
code there wouldn't be noticeable.

-- 
Måns Rullgård
mru@kth.se


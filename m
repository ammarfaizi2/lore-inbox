Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313992AbSDQA5p>; Tue, 16 Apr 2002 20:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313991AbSDQA5e>; Tue, 16 Apr 2002 20:57:34 -0400
Received: from zero.tech9.net ([209.61.188.187]:57098 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313995AbSDQA5U>;
	Tue, 16 Apr 2002 20:57:20 -0400
Subject: Re: Why HZ on i386 is 100 ?
From: Robert Love <rml@tech9.net>
To: davidm@hpl.hp.com
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15548.50859.169392.857907@napali.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 20:57:09 -0400
Message-Id: <1019005044.1670.16.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 20:49, David Mosberger wrote:

> But since it's popular, I did measure it quickly on a relatively
> slow (old) Itanium box: with 100Hz, the kernel compile was about
> 0.6% faster than with 1024Hz (2.4.18 UP kernel).

One question I have always had is why 1024 and not 1000 ?

Because that is what Alpha does?  It seems to me there is no reason for
a power-of-two timer value, and using 1024 vs 1000 just makes the math
and rounding more difficult.

	Robert Love



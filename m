Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279969AbRJ3OrX>; Tue, 30 Oct 2001 09:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279960AbRJ3OrP>; Tue, 30 Oct 2001 09:47:15 -0500
Received: from mail.inf.elte.hu ([157.181.161.6]:59074 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S279961AbRJ3OrB>;
	Tue, 30 Oct 2001 09:47:01 -0500
Date: Tue, 30 Oct 2001 15:47:34 +0100
From: GOMBAS Gabor <gombasg@inf.elte.hu>
To: Tim Walberg <twalberg@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nasty suprise with uptime
Message-ID: <20011030154733.B27230@pandora.inf.elte.hu>
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011029124753.F21285@one-eyed-alien.net> <4.3.2.7.2.20011029172525.00bb2270@mail.osagesoftware.com> <3BDDE642.8000901@acm.org> <3BDE6A80.3A68A44E@mvista.com> <20011030075043.B4904@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011030075043.B4904@mindspring.com>; from twalberg@mindspring.com on Tue, Oct 30, 2001 at 07:50:43AM -0600
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 07:50:43AM -0600, Tim Walberg wrote:

> Wouldn't it be fairly simple for the kernel to just remember the (wall
> clock) time at boot, and uptime just subtract that from the current
> (wall clock) time?

So every people with faulty CMOS batteries would have 30+ years of
uptime. And if the CMOS date is ahead of the real one and the admin
sets it back, you will get negative uptimes etc. If you want such
amusements, it is far easier to write an uptime program that just calls
random() instead of asking the kernel :)

Gabor

-- 
Gabor Gombas                                       Eotvos Lorand University
E-mail: gombasg@inf.elte.hu                        Hungary

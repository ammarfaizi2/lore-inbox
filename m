Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279971AbRJ3QSE>; Tue, 30 Oct 2001 11:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279997AbRJ3QRy>; Tue, 30 Oct 2001 11:17:54 -0500
Received: from mail.inf.elte.hu ([157.181.161.6]:44501 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S279971AbRJ3QRq>;
	Tue, 30 Oct 2001 11:17:46 -0500
Date: Tue, 30 Oct 2001 17:18:20 +0100
From: GOMBAS Gabor <gombasg@inf.elte.hu>
To: Tim Walberg <twalberg@mindspring.com>, linux-kernel@vger.kernel.org
Subject: Re: Nasty suprise with uptime
Message-ID: <20011030171820.C27230@pandora.inf.elte.hu>
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011029124753.F21285@one-eyed-alien.net> <4.3.2.7.2.20011029172525.00bb2270@mail.osagesoftware.com> <3BDDE642.8000901@acm.org> <3BDE6A80.3A68A44E@mvista.com> <20011030075043.B4904@mindspring.com> <20011030154733.B27230@pandora.inf.elte.hu> <20011030093913.B8312@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011030093913.B8312@mindspring.com>; from twalberg@mindspring.com on Tue, Oct 30, 2001 at 09:39:13AM -0600
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 09:39:13AM -0600, Tim Walberg wrote:

> Hmm... ever hear of NTP?

Do you want to include an NTP daemon in the kernel? The timestamp
you suggested is taken way before any user mode daemon starts. Sure,
you can do the timestamp in userspace if you do not mind to lose a few
minutes precision (or whatever time the NTP daemon needs to
synchronize), but then we could just get rid of /proc/uptime and
claim that the whole thing is an userspace issue.

And what about my home machine if I do not want to dial in to my ISP right
after boot? You say that uptime should not be calculated if there are no
NTP servers reachable?

Gabor

-- 
Gabor Gombas                                       Eotvos Lorand University
E-mail: gombasg@inf.elte.hu                        Hungary

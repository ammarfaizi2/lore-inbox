Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131463AbQLIWC0>; Sat, 9 Dec 2000 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131605AbQLIWCR>; Sat, 9 Dec 2000 17:02:17 -0500
Received: from durham-ar1-228-164.dsl.gte.net ([4.35.228.164]:2311 "EHLO
	smtp.gte.net") by vger.kernel.org with ESMTP id <S131463AbQLIWCG>;
	Sat, 9 Dec 2000 17:02:06 -0500
From: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14898.42117.34020.145433@critterling.garfield.home>
Date: Sat, 9 Dec 2000 16:30:45 -0500
To: Julian Anastasov <ja@ssi.bg>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
In-Reply-To: <Pine.LNX.4.21.0012092218280.877-100000@u>
In-Reply-To: <Pine.LNX.4.21.0012092218280.877-100000@u>
X-Mailer: VM 6.87 under Emacs 20.7.1
Reply-To: v.j.orlikowski@gte.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is precisely my problem.
K6-2, model 8, stepping 12.
Thus far, everything is *fine*, as long as MTRR is not compiled into
the kernel.
If MTRR is compiled into the kernel, I get lock-ups in X *only*, and
the entire machine locks.
I have no data on other CPUs; as I said, I previously had a P166, so
no MTRR there to compare against.
I assume that since you had a K6 266 earlier, with no problems, that
the problem must exist in this model and stepping of the CPU
(otherwise, if it were X you would have seen the problem
previously. Ditto for the kernel).
Kernel gurus, ideas for a workaround, other than "Don't use MTRR"?

Victor
-- 
Victor J. Orlikowski
======================
v.j.orlikowski@gte.net
vjo@raleigh.ibm.com
vjo@us.ibm.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

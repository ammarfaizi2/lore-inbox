Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131203AbQLJAUD>; Sat, 9 Dec 2000 19:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131760AbQLJATx>; Sat, 9 Dec 2000 19:19:53 -0500
Received: from durham-ar1-228-164.dsl.gte.net ([4.35.228.164]:40716 "EHLO
	smtp.gte.net") by vger.kernel.org with ESMTP id <S131203AbQLJATo>;
	Sat, 9 Dec 2000 19:19:44 -0500
From: "Victor J. Orlikowski" <v.j.orlikowski@gte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14898.50377.593756.7641@critterling.garfield.home>
Date: Sat, 9 Dec 2000 18:48:25 -0500
To: Julian Anastasov <ja@ssi.bg>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre25, S3, AMD K6-2, and MTRR....
In-Reply-To: <Pine.LNX.4.21.0012092218280.877-100000@u>
In-Reply-To: <Pine.LNX.4.21.0012092218280.877-100000@u>
X-Mailer: VM 6.87 under Emacs 20.7.1
Reply-To: v.j.orlikowski@gte.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After doing some googling....
It would appear that, in Family 5, Model 8, Stepping 12 of the K6-2,
AMD used a different CPU core, that was more similar to the K6-3, and
that there is a slightly odd way of doing write-combining.

Perhaps this is the problem?
Anyone with more knowledge on the AMD cores care to comment?

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

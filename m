Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289029AbSAVAKj>; Mon, 21 Jan 2002 19:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289065AbSAVAK2>; Mon, 21 Jan 2002 19:10:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:64954 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289029AbSAVAKW>;
	Mon, 21 Jan 2002 19:10:22 -0500
Date: Tue, 22 Jan 2002 03:07:48 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Partha Narayanan <partha@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance Results for Ingo's O(1)-scheduler
In-Reply-To: <OF4544D2BC.16B7A12D-ON85256B48.00817250@raleigh.ibm.com >
Message-ID: <Pine.LNX.4.33.0201220306070.29113-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Jan 2002, Partha Narayanan wrote:

> KERNEL              UP          4-way       8-way
> =========           ======      ======      ======
> 2.4.17              11005       15894       11595
> 2.4.17 + D2 patch   10606       23300       29726
> 2.4.17 + G1 patch   10415       23038       31098
> 2.4.17 + H6 patch   10914       22270       32300
> 2.4.17 + H7 patch   11018       23427       31674
> 2.4.17 + J2 patch   13015       23071       33259

thanks for the testing - i'm happy that it's the kernel with the best
interactive properties (-J2) that has the best VolanoMark results as well.

	Ingo


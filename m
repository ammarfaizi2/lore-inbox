Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285506AbRLYMm1>; Tue, 25 Dec 2001 07:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbRLYMmR>; Tue, 25 Dec 2001 07:42:17 -0500
Received: from grootstal.nijmegen.internl.net ([217.149.192.7]:55194 "EHLO
	grootstal.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id <S285506AbRLYMmL>; Tue, 25 Dec 2001 07:42:11 -0500
Date: Tue, 25 Dec 2001 13:42:48 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: <=2.4.17 deadlock (RedHat 7.2, SMP, ext3 related?) (2)
Message-ID: <20011225134248.A8811@iapetus.localdomain>
In-Reply-To: <002101c18cb7$f575b3c0$010411ac@local> <20011224215615.A22826@iapetus.localdomain> <005c01c18cc3$305283f0$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <005c01c18cc3$305283f0$010411ac@local>; from manfred@colorfullife.com on Mon, Dec 24, 2001 at 10:36:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 10:36:11PM +0100, Manfred Spraul wrote:
> If you are brave, you can try the attached patch.

Your assuptions about the address of kernel_flag and
all_ppp_lock were correct (except for an obvious typo).

The patch seems to work, no deadlocks so far but I'll keep
an eye on it.


Thanks,

-- 
Frank

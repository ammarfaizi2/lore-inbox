Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270593AbRH1Klp>; Tue, 28 Aug 2001 06:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270657AbRH1Klf>; Tue, 28 Aug 2001 06:41:35 -0400
Received: from motgate.mot.com ([129.188.136.100]:23741 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id <S270649AbRH1KlX>;
	Tue, 28 Aug 2001 06:41:23 -0400
Message-Id: <3B8B755F.D6317A9A@crm.mot.com>
Date: Tue, 28 Aug 2001 12:41:35 +0200
From: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>
Reply-To: Emmanuel Varagnat-AEV010 
	  <Emmanuel_Varagnat-AEV010@email.mot.com>
Organization: Centre de Recherche de Motorola - Paris
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com.suse.lists.linux.kernel> <3B8AA7B9.8EB836FF@namesys.com.suse.lists.linux.kernel> <oupsneck77v.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:
> 
> It does not really look like a locking problem. If you look at the profiling
> logs it is pretty clear that the problem is the algorithm used in
> bitmap.c:find_forward. find_forward and reiserfs_in_journal
> ...
> journaled blocks set also, to quickly skip them for the common case.

I'm very interested in the way you did profiling.
Did you compile the kernel with profiling options (gprof ?) ?
If so, where the profiling information file is saved ?

Thanks

-Manu

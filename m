Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUCTP4i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbUCTP4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:56:38 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:1460 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263452AbUCTP4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:56:35 -0500
Date: Sat, 20 Mar 2004 07:56:37 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <2696050000.1079798196@[10.10.2.4]>
In-Reply-To: <20040320123009.GC9009@dualathlon.random>
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm working on my code yes, I think my code is finished, I prefer my
> design for the various reasons explained in the other emails (you don't
> swap so you can't appreciate the benefits, you only have to check that
> performs as well as Hugh's code).
> 
> Hugh's and your code is unstable in objrmap, you can find the details in
> the email I sent to Hugh, mine is stable (running such simulation for a
> few days just fine on 4-way xeon, without my objrmap fixes it live locks
> as soon as it hits swap).
> 
> You find my anon_vma in 2.6.5-rc1aa2, it's rock solid, just apply the
> whole patch and compare it with your other below results. thanks.

Mmmm, if you have a broken out patch, it'd be preferable. If I were to 
apply the whole of -mjb, I'll get a damned sight better results than 
any of them, but that's not really a fair comparison ;-) I'll can at 
least check it's stable for me that way though. 

I did find your broken-out anon-vma patch, but it's against something
else, maybe half-way up your tree or something, and I didn't bother
trying to fix it ;-)

M.


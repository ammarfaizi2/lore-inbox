Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbSITKce>; Fri, 20 Sep 2002 06:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbSITKce>; Fri, 20 Sep 2002 06:32:34 -0400
Received: from dp.samba.org ([66.70.73.150]:42221 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262126AbSITKcd>;
	Fri, 20 Sep 2002 06:32:33 -0400
Date: Fri, 20 Sep 2002 20:32:17 +1000
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] pidhash-fix-2.5.36-A0
Message-ID: <20020920103217.GG13384@krispykreme>
References: <Pine.LNX.4.44.0209201104300.30613-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209201104300.30613-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> the attached patch (against BK-curr) fixes a bug in the new PID allocator,
> which bug can cause incorrect hashing of the PID structure which causes
> infinite loops in find_pid(). [and potentially other problems.]

Thanks Ingo,

I havent been able to lock up current BK yet with this patch. I'll continue
to hit it with SDET overnight.

Anton

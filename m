Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSA0S2H>; Sun, 27 Jan 2002 13:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288344AbSA0S15>; Sun, 27 Jan 2002 13:27:57 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:50145 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S288342AbSA0S1u>;
	Sun, 27 Jan 2002 13:27:50 -0500
Date: Sun, 27 Jan 2002 19:27:40 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: c o r e <core@axley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 bug: mysterious hang
Message-ID: <20020127192740.B32485@fafner.intra.cogenit.fr>
In-Reply-To: <1011997901.3c51dccd0d8db@webmail2.axley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1011997901.3c51dccd0d8db@webmail2.axley.net>; from core@axley.net on Fri, Jan 25, 2002 at 02:31:41PM -0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

c o r e <core@axley.net> :
> I sent a couple of e-mails in December 2001 about this issue (latest on
> 12-22-2001) and haven't seen any follow-ups that could either a) help me debug
> the problem or b) fix the problem.    I have tried booting without any modules

(<URL:http://www.cs.helsinki.fi/linux/linux-kernel/2001-50/1508.html> was one)

Your reports suggests you have celeron and use smp -> bp6 owner ?

Assuming big_directory = compiled kernel tree with everything as modules
1 - X disabled: ( tar cf - big_directory | cd /tmp && tar xf -)
    no lock ? See 2)
2 - X disabled: ( tar cvf - big_directory | cd /tmp && tar xvf -)
    no lock ? See 3)
3 - X enabled + xterm: ( tar cf - big_directory | cd /tmp && tar xf -)
    no lock ? See 4)
4 - X enabled + xterm: ( tar cvf - big_directory | cd /tmp && tar xvf -)
    Still no lock ?

-- 
Ueimor

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274603AbRIUCgy>; Thu, 20 Sep 2001 22:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274637AbRIUCgo>; Thu, 20 Sep 2001 22:36:44 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:21521 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274603AbRIUCgk>; Thu, 20 Sep 2001 22:36:40 -0400
Subject: Re: 2.4.9-ac12 weird mc hang
From: Robert Love <rml@tech9.net>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <200109210517.f8L5Hje00537@vegae.deep.net>
In-Reply-To: <200109210517.f8L5Hje00537@vegae.deep.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.20.15.42 (Preview Release)
Date: 20 Sep 2001 22:37:07 -0400
Message-Id: <1001039831.7291.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-21 at 01:17, Samium Gromoff wrote:
>         Hello folks ac12-preempt popped with a new issue:
>     strange it is or not, but i cant start mc since it hangs
>   in random places (as strace shows).
>   	Except my thought that its preempt-unrelated there isnt
>   much to add. Btw console losing issues are back... grr... :(
>         Even glibc/mc recompilation seems not to help...

Please don't send preempt bugs to Alan.  Only if the bug is reproducible
outside of the preempt patch should Alan see it.  Certainly send it to
the list, but make sure its marked as such.

You are the third person to report this problem.  The first person had
the problem go away when he mounted root on a non-ReiserFS partition, so
I blamed ReiserFS.  The second person had the problem go away when he
recompiled his kernel without Athlon optimizations.  So I am baffled.

You aren't using gcc-3, are you?

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266557AbRGDWKR>; Wed, 4 Jul 2001 18:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266561AbRGDWKI>; Wed, 4 Jul 2001 18:10:08 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:46800 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S266557AbRGDWJz>; Wed, 4 Jul 2001 18:09:55 -0400
Message-ID: <3B4394A8.10D0AFE1@idcomm.com>
Date: Wed, 04 Jul 2001 16:11:52 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <994279551.1116.0.camel@tux>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje wrote:
> 
> Hi,
> 
> you might remember an e-mail from me (two weeks ago) with my problems
> where linux would not boot up or be highly instable on a machine with
> 256 MB RAM, while it was 100% stable with 128 MB RAM. Basically, I still
> have this problem, so I am running with 128 MB RAM again.

Some motherboards have ram requirements that might not be obvious
without reading the m/b manual. For example, some m/b's require
registered memory. Some don't work with ECC. Some require modules be
installed in pairs (of exact type match). Some require that larger
memory sticks be placed in earlier slots relative to smaller modules.
And if you add a wait state in the bios a marginal ram module can become
quite stable; the unstable version can behave differently under
different circumstances (including temperature). Check the m/b manual
and m/b web site for exact requirements, and make sure the ram matches;
even if your memory is good, it might not be good in your circumstances.

D. Stimits, stimits@idcomm.com

> 
> I've been running Mandrake 7.2 on another machine for some time - no
> problem, until..... I added another 64 MB RAM and tried to install
> redhat (25 times (!!!)) and Mandrake 8.0... Both crash with memory
> faults..... Redhat just freezes or givesa a python warning, Mandrake
> gives a segfault with a warning that "memory is missing".... Both refuse
> to complete installation...
> 
> I'm kind of astounded now, WHY can't linux-2.4.x run on ANY machine in
> my house with more than 128 MB RAM?!? Can someone please point out to me
> that he's actually running kernel-2.4.x on a machine with more than 128
> MB RAM and that he's NOT having severe stability problems?
> And can that same person PLEASE point out to me why 2.4.x is crashing on
> me (or help me to find out...)?
> 
> First machine is a Intel P-II 400 with 128 MB RAM (133 MHz SDRAM) and
> crashing when I insert an additional 128 - it's running RH-7.0 with
> kernel-2.4.4. Second machine is an AMD Duron 600 with 196 MB RAM (also
> 133 MHz SDRAM), crashing during the installation of both Mandrake 8.0
> and Redhat 7.1 and which used to run stable with 128 MB RAM or 64 MB RAM
> with Mandrake-7.2. Win2k runs stable on this machine in all
> configurations.
> 
> I'm getting desperate.... win2k is running stable and it's scary to see
> linux crash while win2k runs stable and smooth.
> 
> (ps I'm not subscribed to the list - please CC a copy to me when
> replying)
> 
> Thanks in advance for any help on this,
> 
> --
> Ronald Bultje
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

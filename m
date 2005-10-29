Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVJ2G6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVJ2G6b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 02:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVJ2G6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 02:58:30 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:21114 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750933AbVJ2G6a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 02:58:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NiIXyD/PAP8UgyuFVBbFat6uxVD2/A58/bOo6sM+YoVM5PUtSIOD62wYe981qHzJ6ga8CEmvYppL72vHzbm4aK0WmF2WU4/hHj718OFY7WJ66B/b+t4RiX5dSPCQ+mRtpYi+k2DFMEqs75uIEM0jyhTrWHvI+/4llyjQBEPWrBw=
Message-ID: <174467f50510282358o61c5d977u@mail.gmail.com>
Date: Sat, 29 Oct 2005 14:58:29 +0800
From: Boxer Gnome <aiko.sex@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: boot ok,but reboot hang, from 2.6.10 to 2.6.14
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0510282104500.3348@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <174467f50510280544g5fffdfaeq@mail.gmail.com>
	 <Pine.LNX.4.64.0510280733000.4664@g5.osdl.org>
	 <174467f50510281926tfcbcc4bi@mail.gmail.com>
	 <Pine.LNX.4.64.0510282104500.3348@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/10/29, Linus Torvalds <torvalds@osdl.org>:
>
>
> On Sat, 29 Oct 2005, Boxer Gnome wrote:
> >
> > I tested the 2.6.10-rc1 and 2.6.10-rc2,the 2.6.10-rc1 rebooted ok,but
> > the 2.6.10-rc2 has that problem.
>
> Thanks. So it's between 2.6.10-rc1 and -rc2. Good. However:
>
> > Then I test the snapshot
> > 2.6.10-rc2-bk1,2.6.10-rc2-bk4,2.6.10-rc2-bk8,they all have this reboot
> > hang.
>
> Actually, you should test 2.6.10-rc1-bk*, not -rc2-bk*.
>
> The "-bkxxx" kernels are not release-candidates, so they are not "before"
> the real release. They are nightly snapshots _after_ the release, so
> 2.6.10-rc2-bk1 is the first snapshot after 2.6.10-rc2.
>
> So you'd be interested in the ones after -rc1, but before -rc2.
>
>                Linus
>
OK,I'd tested the 2.6.10-rc1-bk1,2.6.10-rc1-bk6,2.6.10-rc1-bk12,I
found the 2.6.10-rc1-bk1, 2.6.10-rc1-bk6  rebooted ok,but the
2.6.10-rc1-bk12 has that problem.


Then I tested the 2.6.10-rc1-bk8,2.6.10-rc1-bk9,2.6.10-rc1-bk10.

The 2.6.10-rc1-rc8 was still ok.the 2.6.10-rc1-bk9 began has the
reboot_hang_after_POST.

Hope this help you.

Thanks

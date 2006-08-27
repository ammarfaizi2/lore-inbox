Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWH0Oub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWH0Oub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 10:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWH0Oub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 10:50:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:59226 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932131AbWH0Oua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 10:50:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=olTERyTvxOBNZa4/zL8N4ZZTMPhmgPUIjnjxfyJ9m0pz04y3X4vLGQ/WvhBdkwQWDdqq2SbgTAtNjtOtU+Pb5syV+MG5EDA8BsZUnMwnvk4cNBx3jYiih7yDycLZs+Q8ETMNg6HhUuMN0g5szVO6ye0jXLB6df9nf/lN394NnfA=
Message-ID: <7c3341450608270750t26f81d02s45e6b05572b0e255@mail.gmail.com>
Date: Sun, 27 Aug 2006 15:50:29 +0100
From: "Nick Warne" <nick.warne@gmail.com>
Reply-To: nick@linicks.net
To: "Mikael Pettersson" <mikpe@it.uu.se>
Subject: Re: Linux 2.4.33.2
Cc: linux-kernel@vger.kernel.org, wtarreau@hera.kernel.org,
       gcoady.lk@gmail.com, mtosatti@redhat.com, volkerdi@slackware.com
In-Reply-To: <200608271235.k7RCZlru005427@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608271235.k7RCZlru005427@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good question - all I can find is the slackware package - and it
appears not many mirrors have this yet:

http://slackware.it/en/pb/package.php?q=current/glibc-solibs-2.3.6-i486-5

Nick

On 27/08/06, Mikael Pettersson <mikpe@it.uu.se> wrote:
> On Tue, 22 Aug 2006 21:23:00 +0000, Willy Tarreau wrote:
> >### Important note for users of Slackware 10.2 ###
> >
> >Grant Coady informed me that 2.4.33.1 did not boot for him. After a long
> >series of tests from him and Pat Volkerding, it appeared that the problem
> >is caused by glibc 2.3.6 wrongly detecting kernel version as 4.33.1 and
> >mistakenly using the NTPL libs instead.
> >
> >Patrick has fixed the problem and will (has ?) send the fix to the glibc
> >team. By now people using Slackware 10.2 must upgrade their glibc to
> >glibc-solibs-2.3.5-i486-6_slack10.2.tgz if they want to run a 2.4.33.x
> >kernel (user glibc-2.3.6 build -5 for -current). A workaround is either
> >to rename /lib/tls or to rename the kernel to something different than
> >4 numbers separated by dots. Since the problem is fixed, I don't intend
> >to change the numbering.
> >
> >I dont think that this problem might affect many other distros since those
> >shipping an NPTL-enabled libc with both 2.4 and 2.6 mainline are rare. If
> >anyone else encounters the problem, Pat has the fix.
>
> Can anyone provide a URL to the glibc fix?
> While I don't use Slackware and haven't been bitten by
> the bug (yet), I want to review the fix for possible
> inclusion in my glibc patch kit.
>
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

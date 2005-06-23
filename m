Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVFWWMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVFWWMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVFWWHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:07:31 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:44611 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262718AbVFWWAx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:00:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=epF8ozoqVHuanQRuKwlL83LjnIcHIO3wH8Y03EJTQfoiZbwtH7x0piB/s/30+DcgGJFd4Id8COv+0pz7pxrv0TO0VenhVnKWvhv8isJtrfkXf6Oy7QntHGhZunc/gEJMFTzl5Ls0VrqhUWbYMwsQUtaiqbphRWHCxKFcIqijLYk=
Message-ID: <f0cc385605062314543a25019e@mail.gmail.com>
Date: Thu, 23 Jun 2005 23:54:31 +0200
From: "M." <vo.sinh@gmail.com>
Reply-To: "M." <vo.sinh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Cc: reiserfs-list@namesys.com
In-Reply-To: <200506232249.47302.michael.dreher@uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42BAC304.2060802@slaphack.com>
	 <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
	 <20050623221222.33074838.reiser4@blinkenlights.ch>
	 <200506232249.47302.michael.dreher@uni-konstanz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we are talking about reiser4, not reiser3..

Michele

On 6/23/05, Michael Dreher <michael.dreher@uni-konstanz.de> wrote:
> >>>                                                 Not everyone will want
> >>> to reformat at once, but as the reiser4 code matures and proves itself
> >>> (even more than it already has),
> >>
> >> I for one have seen mainly people with wild claims that it will make
> >> their machines much faster, and coming back later asking how they can
> >> recover their thrashed partitions...
> >
> > Then please show us some Links/Message-IDs to such postings.
> > I'd like to read them.
> 
> Here you are....
> 
> The following happened to me with reiserfs as it was shipped with
> suse 9.1:
> 
> ------------------------------------------------------------------
> dreher@euler03:~/mytex/konstanz/wohnung> ls
> auto          makler2.aux  makler2.log  makler2.tex  makler.aux  makler.log
> swk.eps      unilogo.eps
> briefkpf.tex  makler2.dvi  makler2.ps   makler3.tex  makler.dvi  makler.tex
> unikopf.tex
> dreher@euler03:~/mytex/konstanz/wohnung> rm *.aux *.log
> rm: cannot remove `makler2.log': No such file or directory
> dreher@euler03:~/mytex/konstanz/wohnung> ls
> auto  briefkpf.tex  makler2.dvi  makler2.ps  makler2.tex  makler3.tex
> makler.dvi  makler.tex  swk.eps  unikopf.tex  unilogo.eps
> dreher@euler03:~/mytex/konstanz/wohnung> uname -a
> Linux euler03 2.6.5-7.108-smp #1 SMP Wed Aug 25 13:34:40 UTC 2004 i686 i686
> i386 GNU/Linux
> dreher@euler03:~/mytex/konstanz/wohnung> date
> Tue Sep 21 13:15:45 CEST 2004
> ----------------------------------------------------------
> 
> Note the line "rm: cannot remove `makler2.log': No such file or directory"
> 
> There was no data loss, but such a bug should not happen.
> I never had similar experiences with ext3.
> 
> Unfortunately, I cannot reproduce this behavior.
> 
> >  Powerloss, unpluging the Disk while writing, full filesystem,
> >  heavy use : No problems with reiser4.. It *is* stable.
> 
> My impression: reiser3 is not 100% stable, but quite stable,
> written by someone who asks for "review by benchmark".
> 
> Michael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

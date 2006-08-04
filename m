Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWHDJWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWHDJWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHDJWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 05:22:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64235 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751394AbWHDJWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 05:22:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NBFycosPdOacz4cPUtlUcb/ArnCXY3/E4+rgdMFS2j5uzSngl2u7USKKOcuuEy1+gswrAO1ccCPjIja1dSeVGIOlALk+X0OmmrdLf8bSPoMtNN+mi84WRODylWToHqrYkhEEiuMN6LfPF5x4nDxtBoUFiPhlJa/xqziMSz3eUXA=
Message-ID: <9a8748490608040222q74f1d8e9vdd29048c9d6f395a@mail.gmail.com>
Date: Fri, 4 Aug 2006 11:22:21 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch 00/23] -stable review
Cc: "Auke Kok" <auke-jan.h.kok@intel.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, reviews@ml.cw.f00f.org,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20060804021950.3493e85d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060804053807.GA769@kroah.com>
	 <9a8748490608040204o58f7f594qe8c3316fcdf00ea4@mail.gmail.com>
	 <20060804021950.3493e85d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/06, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 4 Aug 2006 11:04:36 +0200
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> > On 04/08/06, Greg KH <gregkh@suse.de> wrote:
> > > This is the start of the stable review cycle for the 2.6.17.8 release.
> > > There are 23 patches in this series, all will be posted as a response to
> > > this one.  If anyone has any issues with these being applied, please let
> > > us know.  If anyone is a maintainer of the proper subsystem, and wants
> > > to add a Signed-off-by: line to the patch, please respond with it.
> > >
> > > These patches are sent out with a number of different people on the Cc:
> > > line.  If you wish to be a reviewer, please email stable@kernel.org to
> > > add your name to the list.  If you want to be off the reviewer list,
> > > also email us.
> > >
> > > Responses should be made by Sunday, August 6, 05:00:00 UTC.  Anything
> > > received after that time might be too late.
> > >
> > > I've also posted a roll-up patch with all changes in it if people want
> > > to test it out.  It can be found at:
> > >
> > >         kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17.8-rc1.gz
> > >
> >
> > Any chance that the fixes in the (latest) e1000 driver version
> > 7.1.9-k4 will get backported?
>
> The post-2.6.17 e1000 changes are massive.
>
I know, I tried backporting the new driver but gave up.


> > I can't run 2.6.17.7 on at least one of my servers due to bugs in the
> > driver that are fixed in the latest e1000 version.
> > I looked through the -stable patches but didn't find anything that
> > would fix my problem.
> > I get messages along the lines of "kernel: Virtual device XXX asks to
> > queue packet!" and the device then refuses to work.
> > The last kernel where I know for a fact that it worked OK is 2.6.11,
> > so that's what the server is currently running.
> >
> > Getting the fix for that problem backported to -stable would really make my day.
>
>
> Perhaps the e1000 developers can help us to identify the particular fix for
> this problem.
>
That's what I was hoping for...


> That's assuming that it is actually fixed.  Does 2.6.18-current fix the bug?
>
I tested 2.6.18-rc3-git3 and that did indeed fix the e1000 bug, but I
can't run that kernel since xfs crashes :-(  (I've send a sepperate
bug report for that)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

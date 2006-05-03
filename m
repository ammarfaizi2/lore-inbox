Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWECMdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWECMdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWECMdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:33:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:39741 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965176AbWECMdK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:33:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dt4l4zT0ka4K1k1/ouH+NRsK3SLaoKRWGnlLF4HywDfqYP8IZlnyS2Ni3lv1CTXbr6nQLsmJi1iatKyWPhOOJKgpquI694uXeK0R35FNkj1qlAgIPqGPClGqHxDTnJnKK8x86ptC+19JcRVQtj89lVSzryz4lJF0qmFDPiP3mf0=
Message-ID: <9a8748490605030533q16349329k6d7f0bdb242dc360@mail.gmail.com>
Date: Wed, 3 May 2006 14:33:09 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>,
       "Yogesh Pahilwan" <pahilwan.yogesh@spsoftindia.com>
Subject: Re: Problem while applying patch to 2.6.9 kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0605030809100.24221@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAwZsyZCSXbUSO0mznjdzGqgEAAAAA@spsoftindia.com>
	 <Pine.LNX.4.58.0605030809100.24221@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/06, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 3 May 2006, Yogesh Pahilwan wrote:
>
> > Hi Kernel Folks,
> >
> > I am facing some problem while applying patch to the 2.6.9 kernel.
> >
> > I have done following to apply the patch:
> >
> > # patch -p1 < ../../Patches/patch-ext3
> >
> > But getting following things:
> >
> > missing header for unified diff at line 3 of patch
> > (Stripping trailing CRs from patch.)

This sounds like a possibly corrupted patch file.


> > can't find file to patch at input line 3
> > Perhaps you used the wrong -p or --strip option?
>
> Hmm, perhaps you have the wrong -p option.
>
> > The text leading up to this was:
> > --------------------------
> > |#--- ../A_CLEAN_FILE_SYSTEM/jbd/commit.c       2006-02-25
>
> Since you didn't show us any of this patch, the above looks like you need
> -p2.
>
Agreed, wrong -p level looks likely.


> You might want to get yourself more familiar with "patch".
>

There's also Documentation/applying-patches.txt which would be good to
read. Online link here :
http://sosdg.org/~coywolf/lxr/source/Documentation/applying-patches.txt?v=2.6


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVESAg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVESAg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVESAg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 20:36:26 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:13 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262424AbVESAgR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 20:36:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SLejDWR+W095n8On9XTi1PSIWUHJX6nR4ZBZYxUvbtCp3paobCJnwiKvpi3ZZ1I1JI4td75laKPA48iVTdD53LpsqsT9md4kmkti0yXxTuo4raPnGbnjCoeKaVwWGIlHYatSKgsFfdmlC1pp1vcmShkNtavSEn520kL+jC5HHUo=
Message-ID: <90f56e4805051817361eaa02bd@mail.gmail.com>
Date: Wed, 18 May 2005 17:36:17 -0700
From: Ajay Patel <patela@gmail.com>
Reply-To: Ajay Patel <patela@gmail.com>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: GDB, pthreads, and kernel threads
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <428BDA56.5030502@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <45k9a-7DD-11@gated-at.bofh.it> <45xIX-2bR-31@gated-at.bofh.it>
	 <45zKO-3RV-45@gated-at.bofh.it> <428BDA56.5030502@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an exactly same problem.
My platform is PPC, Linux 2.6.11.4, glibc 2.3.4 with linux threads.

One thing I observed that the problem only occurs
when break point is set in non-main thread.

Thanks
Ajay


On 5/18/05, Robert Hancock <hancockr@shaw.ca> wrote:
> John Clark wrote:
> > I built the latest GDB-6.3, as well as rebuilt glibc-2.3.5, and now when
> > I step through the
> > main code line, which creates the tasks (I'm using the pthreads.c from
> > the GDB testsuite), I do
> > not getany output from:
> >
> > info threads
> >
> > When I set a break point on the entry point of one of the
> > soon-to-be-created threads,
> > I get a diagnostic message:
> >
> > Program terminated with signal SIGTRAP, Trace/Breakpoint trap.
> > The program no longer exists.
> 
> Are you sure your glibc and gdb were both configured to support threads
> when they were compiled?
> 
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265163AbSKES6i>; Tue, 5 Nov 2002 13:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265165AbSKES6i>; Tue, 5 Nov 2002 13:58:38 -0500
Received: from fmr02.intel.com ([192.55.52.25]:47054 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265163AbSKES6f>; Tue, 5 Nov 2002 13:58:35 -0500
Message-ID: <004801c284fe$425ee4b0$77d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Rusty Lynch" <rusty@linux.co.intel.com>,
       "Stephanie Glass" <sglass@us.ibm.com>
Cc: "Dan Kegel" <dkegel@ixiacom.com>,
       "Geoff Gustafson" <geoff@linux.co.intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <OF6C3388E1.FE6DBF03-ON86256C68.006400A7@pok.ibm.com>
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
Date: Tue, 5 Nov 2002 11:05:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We started with a few areas like message queues and signals, but it is just
a starting point.

    -rusty (hmm... guess rusty is already taken in this domain.  maybe I
should sign rustyl :->)

----- Original Message -----
From: "Stephanie Glass" <sglass@us.ibm.com>
To: "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: "Dan Kegel" <dkegel@ixiacom.com>; "Geoff Gustafson"
<geoff@linux.co.intel.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, November 05, 2002 10:24 AM
Subject: Re: [ANNOUNCE] Open POSIX Test Suite


>
> Rusty,
> We will take them.  We may set them up not to run with our runall portion
> but as a separate run.  This is how we do several areas, such as
> networking.   Just let us know when you are ready to start contributing.
> It doesn't have to be all at once, we will take in stages also.  We put
out
> a new version almost every month so we can get them out there quickly.
>
> Don't most of these test cases deal with things like POSIX timers,
> semaphores, threads, etc.?  Or are these other types of tests?
>
> Thanks
>
> Stephanie
>
> Linux Technology Center
>  IBM, 11400 Burnet Road, Austin, TX  78758
>  Phone: (512) 838-9284   T/L: 678-9284  Fax: (512) 838-3882
>  E-Mail: sglass@us.ibm.com
>
>
>
>                       "Rusty Lynch"
>                       <rusty@linux.co.i        To:       "Geoff Gustafson"
<geoff@linux.co.intel.com>, Stephanie
>                       ntel.com>                 Glass/Austin/IBM@IBMUS
>                                                cc:       "Dan Kegel"
<dkegel@ixiacom.com>, "Linux Kernel Mailing List"
>                       11/05/2002 10:43
<linux-kernel@vger.kernel.org>
>                       AM                       Subject:  Re: [ANNOUNCE]
Open POSIX Test Suite
>
>
>
>
>
>
> Stephanie,
>
> All test are GPL, so anyone can do anything they want with them.  We would
> be happy to donate test to any project.
>
> The truth is that we modeled test cases after LTP, meaning that a test
case
> is
> a simple executable that returns 0 for success and anything else to
> indicate
> failure, so copying a test from posixtest to LTP should be very easy.
>
> I was under the impression that LTP did not want to accept a bunch of test
> cases that did not currently have an associated implementation in Linux.
> It sounds like this is not exactly correct.  How about test cases that
will
> probably
> always be implemented in user space?  Isn't LTP specific to kernel
testing?
>
>     -rusty
>
> ----- Original Message -----
> From: "Stephanie Glass" <sglass@us.ibm.com>
> To: "Geoff Gustafson" <geoff@linux.co.intel.com>
> Cc: "Dan Kegel" <dkegel@ixiacom.com>; "Linux Kernel Mailing List"
> <linux-kernel@vger.kernel.org>
> Sent: Tuesday, November 05, 2002 7:49 AM
> Subject: Re: [ANNOUNCE] Open POSIX Test Suite
>
>
> >
> > Geoff,
> > The LTP would be happy to have anyone in the Linux community donate test
> > cases.  This includes any POSIX tests.
> > The LTP would not be advertised as a POSIX compliance test, that would
be
> > up to LSB to handle.  These tests
> > would only increase the overall LTP api coverages.
> >
> > Does your group own these tests?  Do you want to donate them to the LTP?
> >
> > Stephanie
> >
> > Linux Technology Center
> >  IBM, 11400 Burnet Road, Austin, TX  78758
> >  Phone: (512) 838-9284   T/L: 678-9284  Fax: (512) 838-3882
> >  E-Mail: sglass@us.ibm.com
> >
> >
> >
> >                       "Geoff Gustafson"
> >                       <geoff@linux.co.i        To:       "Dan Kegel"
> <dkegel@ixiacom.com>, "Linux Kernel Mailing List"
> >                       ntel.com>
> <linux-kernel@vger.kernel.
> org>
> >                                                cc:       Stephanie
> Glass/Austin/IBM@IBMUS
> >                       11/04/2002 06:04         Subject:  Re: [ANNOUNCE]
> Open POSIX Test Suite
> >                       PM
> >
> >
> >
> >
> >
> > > You are about to duplicate http://ltp.sf.net
> >
> > My understanding is that LTP is focused on current mainline kernel
> testing,
> > while this project's initial concern is areas that are not currently in
> > Linux
> > like POSIX message queues, semaphores, and full support for POSIX
> threads.
> > I see
> > this as being used to evaluate different implementations that are being
> > considered for inclusion in the kernel, glibc, etc.
> >
> > This project is concerned with the POSIX APIs regardless of where they
> are
> > implemented (kernel, glibc, etc.). Thus it can focus on POSIX,
> independent
> > of
> > implementation. This project will be more concerned with traceability
> back
> > to
> > the POSIX specification, and completeness of coverage, than I would
> expect
> > from
> > LTP.
> >
> > That said, there is some overlap, and an exchange of test cases between
> the
> > projects may be very useful.
> >
> > I've copied Stephanie from LTP to get her reaction.
> >
> > -- Geoff Gustafson
> >
> > These are my views and not necessarily those of my employer.
> >
> >
> >
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


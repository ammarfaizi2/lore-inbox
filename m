Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265030AbSKESS3>; Tue, 5 Nov 2002 13:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265087AbSKESS3>; Tue, 5 Nov 2002 13:18:29 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:25592 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265030AbSKESST>;
	Tue, 5 Nov 2002 13:18:19 -0500
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
To: "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: "Dan Kegel" <dkegel@ixiacom.com>,
       "Geoff Gustafson" <geoff@linux.co.intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF6C3388E1.FE6DBF03-ON86256C68.006400A7@pok.ibm.com>
From: "Stephanie Glass" <sglass@us.ibm.com>
Date: Tue, 5 Nov 2002 12:24:38 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and RM_DEBUG |October 24, 2002) at 11/05/2002 01:24:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty,
We will take them.  We may set them up not to run with our runall portion
but as a separate run.  This is how we do several areas, such as
networking.   Just let us know when you are ready to start contributing.
It doesn't have to be all at once, we will take in stages also.  We put out
a new version almost every month so we can get them out there quickly.

Don't most of these test cases deal with things like POSIX timers,
semaphores, threads, etc.?  Or are these other types of tests?

Thanks

Stephanie

Linux Technology Center
 IBM, 11400 Burnet Road, Austin, TX  78758
 Phone: (512) 838-9284   T/L: 678-9284  Fax: (512) 838-3882
 E-Mail: sglass@us.ibm.com


                                                                                                                             
                      "Rusty Lynch"                                                                                          
                      <rusty@linux.co.i        To:       "Geoff Gustafson" <geoff@linux.co.intel.com>, Stephanie             
                      ntel.com>                 Glass/Austin/IBM@IBMUS                                                       
                                               cc:       "Dan Kegel" <dkegel@ixiacom.com>, "Linux Kernel Mailing List"       
                      11/05/2002 10:43          <linux-kernel@vger.kernel.org>                                               
                      AM                       Subject:  Re: [ANNOUNCE] Open POSIX Test Suite                                
                                                                                                                             
                                                                                                                             
                                                                                                                             



Stephanie,

All test are GPL, so anyone can do anything they want with them.  We would
be happy to donate test to any project.

The truth is that we modeled test cases after LTP, meaning that a test case
is
a simple executable that returns 0 for success and anything else to
indicate
failure, so copying a test from posixtest to LTP should be very easy.

I was under the impression that LTP did not want to accept a bunch of test
cases that did not currently have an associated implementation in Linux.
It sounds like this is not exactly correct.  How about test cases that will
probably
always be implemented in user space?  Isn't LTP specific to kernel testing?

    -rusty

----- Original Message -----
From: "Stephanie Glass" <sglass@us.ibm.com>
To: "Geoff Gustafson" <geoff@linux.co.intel.com>
Cc: "Dan Kegel" <dkegel@ixiacom.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, November 05, 2002 7:49 AM
Subject: Re: [ANNOUNCE] Open POSIX Test Suite


>
> Geoff,
> The LTP would be happy to have anyone in the Linux community donate test
> cases.  This includes any POSIX tests.
> The LTP would not be advertised as a POSIX compliance test, that would be
> up to LSB to handle.  These tests
> would only increase the overall LTP api coverages.
>
> Does your group own these tests?  Do you want to donate them to the LTP?
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
>                       "Geoff Gustafson"
>                       <geoff@linux.co.i        To:       "Dan Kegel"
<dkegel@ixiacom.com>, "Linux Kernel Mailing List"
>                       ntel.com>
<linux-kernel@vger.kernel.
org>
>                                                cc:       Stephanie
Glass/Austin/IBM@IBMUS
>                       11/04/2002 06:04         Subject:  Re: [ANNOUNCE]
Open POSIX Test Suite
>                       PM
>
>
>
>
>
> > You are about to duplicate http://ltp.sf.net
>
> My understanding is that LTP is focused on current mainline kernel
testing,
> while this project's initial concern is areas that are not currently in
> Linux
> like POSIX message queues, semaphores, and full support for POSIX
threads.
> I see
> this as being used to evaluate different implementations that are being
> considered for inclusion in the kernel, glibc, etc.
>
> This project is concerned with the POSIX APIs regardless of where they
are
> implemented (kernel, glibc, etc.). Thus it can focus on POSIX,
independent
> of
> implementation. This project will be more concerned with traceability
back
> to
> the POSIX specification, and completeness of coverage, than I would
expect
> from
> LTP.
>
> That said, there is some overlap, and an exchange of test cases between
the
> projects may be very useful.
>
> I've copied Stephanie from LTP to get her reaction.
>
> -- Geoff Gustafson
>
> These are my views and not necessarily those of my employer.
>
>
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/







Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131749AbQKJWNW>; Fri, 10 Nov 2000 17:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbQKJWNM>; Fri, 10 Nov 2000 17:13:12 -0500
Received: from [151.4.188.87] ([151.4.188.87]:44036 "HELO home.bogus")
	by vger.kernel.org with SMTP id <S131749AbQKJWMx>;
	Fri, 10 Nov 2000 17:12:53 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
To: sendmail-bugs@sendmail.org, Neil W Rickert <sendmail+rickert@sendmail.org>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Date: Sat, 11 Nov 2000 00:25:23 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: sendmail-bugs@sendmail.org, linux-kernel@vger.kernel.org
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu>
In-Reply-To: <26054.973893835@euclid.cs.niu.edu>
MIME-Version: 1.0
Message-Id: <00111100294900.00921@linux1.home.bogus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, Neil W Rickert wrote:
> "Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
> 
> >The problem of dropping connections on 2.4 was related to the O RefuseLA
> >settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
> >clearly set too low for modern Linux kernels.  You may want them cranked
> >up to 100 or something if you want sendmail to always work.  
> 
> If a modern Linux kernel requires high load average defaults, I will
> stop using Linux.

It _depends_ on what the kernel is doing.
In my Co. We've our MTA ( PIII 800 ) with LA > 40 often ...
but it's processing a sustained load of 120000 msg/hour.



- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

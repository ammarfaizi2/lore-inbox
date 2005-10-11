Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVJKWX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVJKWX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJKWX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:23:56 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:54586 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751018AbVJKWXz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:23:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dW6OQuibY5jBfF0+9/Mg2JlEHH7qVy3k473GBprB+kBQwcIDaibGgtFWgLwx4lHAUzJ/9wjECTTRmf1lApiKtHlOAw60YLZXDKALtTixuPUe533x1KhbkEV+wA3WhqGi674FizwtaK0Crw3tJ5oHQeI6CgaAuKvexY6Py3zB2Mo=
Message-ID: <5bdc1c8b0510111523h50572348uabb69d056fabd665@mail.gmail.com>
Date: Tue, 11 Oct 2005 15:23:54 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc4-rt1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <1129065696.4718.10.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510111408n4ef45eadv1e12ec4d1271d971@mail.gmail.com>
	 <5bdc1c8b0510111413q7b1ea391n3bc27924d928b963@mail.gmail.com>
	 <1129065696.4718.10.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Tue, 2005-10-11 at 14:13 -0700, Mark Knecht wrote:
> > The machine had been essentially 'User space idle' for the previous
> > two hours. The screen saver had kicked in. Audio was running and the
> > machine was busy. I woke it up, gave xscreensaver my password, read
> > email, sent the previous mail, then picked up the telephone to make a
> > call. Not 2 seconds later the xruns occurred!
>
> So what does /proc/latency_trace report?
>
> Lee

I have to rebuild the kernel. That just completed but I haven't
rebooted yet. I wanted to base line test just in case all this latency
testing capability built into the kernel was the root cause of my
xruns. Now I know it wasn't.

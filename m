Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313973AbSDKDad>; Wed, 10 Apr 2002 23:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313974AbSDKDac>; Wed, 10 Apr 2002 23:30:32 -0400
Received: from zero.tech9.net ([209.61.188.187]:47365 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313973AbSDKDab> convert rfc822-to-8bit;
	Wed, 10 Apr 2002 23:30:31 -0400
Subject: Re: 0(1)-patch, where did it go?
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, George Anzinger <george@mvista.com>,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <200204110527.35486.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 23:30:35 -0400
Message-Id: <1018495836.6529.153.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-10 at 23:27, Dieter Nützel wrote:

> But I see some kernel hangs with preemption on UP.
> It happens only during "make bzlilo" (the linking stage). Robert?
> Apart from that it works well.

It is probably lock-break, not preempt.  I don't have lock-break patches
for 2.4.19-pre yet.  Lock-break/low-latency and the more general lock
breaking / explicit schedule work is very reliant on the version of the
kernel they were designed against.  This is why this approach is not a
proper long-term solution ...

	Robert Love


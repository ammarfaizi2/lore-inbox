Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313937AbSDKDoV>; Wed, 10 Apr 2002 23:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313974AbSDKDoU>; Wed, 10 Apr 2002 23:44:20 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:38639 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S313937AbSDKDoU>; Wed, 10 Apr 2002 23:44:20 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: Re: 0(1)-patch, where did it go?
Date: Thu, 11 Apr 2002 05:44:13 +0200
X-Mailer: KMail [version 1.4]
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, George Anzinger <george@mvista.com>,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <200204110527.35486.Dieter.Nuetzel@hamburg.de> <1018495836.6529.153.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204110544.13799.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 11. April 2002 :30, Robert Love wrote:
> On Wed, 2002-04-10 at 23:27, Dieter Nützel wrote:
> > But I see some kernel hangs with preemption on UP.
> > It happens only during "make bzlilo" (the linking stage). Robert?
> > Apart from that it works well.
>
> It is probably lock-break, not preempt.  I don't have lock-break patches
> for 2.4.19-pre yet.  Lock-break/low-latency and the more general lock
> breaking / explicit schedule work is very reliant on the version of the
> kernel they were designed against.  This is why this approach is not a
> proper long-term solution ...

OK, thanks Robert will try without it after some sleep.

But preemption without lock-break on 2.4 is like running without preemption.
The general latency problem with O(1) for 2.4 still stands.
Do you have similar observations with the current -ac tree?
You should have my numbers.

I only would bring your focus somewhat back to 2.4 'cause 2.6 is so far...

Thanks,
	Dieter

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271657AbRHQNeK>; Fri, 17 Aug 2001 09:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271653AbRHQNeB>; Fri, 17 Aug 2001 09:34:01 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:38413 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S271650AbRHQNdo>; Fri, 17 Aug 2001 09:33:44 -0400
Date: Fri, 17 Aug 2001 16:47:35 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Wes Felter <wmf@austin.ibm.com>
cc: Eduardo =?ISO-8859-1?Q?Cort=E9s?= <the_beast@softhome.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: limit cpu
In-Reply-To: <997991934.20279.11.camel@arlab191.austin.ibm.com>
Message-ID: <Pine.LNX.4.30.0108171208310.2660-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Aug 2001, Wes Felter wrote:
> On 16 Aug 2001 03:21:58 +0200, Eduardo Cortés wrote:
> > i want to know if linux can limit the max cpu usage (not cpu time) per user,
> > like freebsd login classes. I see /etc/security/limits.conf and ulimit from
> > bash, but they limit the max cpu time, not de max cpu usage (%cpu).
> There are a couple of patches:

A quick summary below, maybe somebody wants to work on this issue,

> http://www.cs.umass.edu/~lass/software/qlinux/

Last modified: Thu Jul 1 14:52:41 EDT 1999
it patches neither 2.2.19 nor 2.4.9 (or other recent kernels)

> http://fairsched.sourceforge.net/

Last updated on 11 July 2000
it patches neither 2.2.19 nor 2.4.9 (or other recent kernels)

> http://www.surriel.com/patches/2.3/2.3.99-3-schedpatch5

Last modified: Tue Apr  4 15:43:40 2000
it patches neither 2.2.19 nor 2.4.9 (or other recent kernels)

Eduardo, as it was mentioned before, you can "mimic" CPU usage
limitation using the 'priority' item in /etc/security/limits.conf that's
basically sets the nice(1) values. It made some people happy.

	Szaka


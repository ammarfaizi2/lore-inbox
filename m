Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSFEKZO>; Wed, 5 Jun 2002 06:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSFEKZN>; Wed, 5 Jun 2002 06:25:13 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:59093 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314403AbSFEKZL>; Wed, 5 Jun 2002 06:25:11 -0400
Date: Wed, 5 Jun 2002 11:56:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Dave Jones <davej@suse.de>
Cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 config forward references to CONFIG_X86_LOCAL_APIC
In-Reply-To: <20020605121420.F5277@suse.de>
Message-ID: <Pine.LNX.4.44.0206051155510.26634-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Dave Jones wrote:

> On Wed, Jun 05, 2002 at 10:07:15AM +0200, Zwane Mwaikambo wrote:
>  > > The forward references result in incorrect configurations when
>  > > switching config from one cpu type to another or from SMP to UP.
>  > We could move the conditional to preprocessor time by wrapping certain 
>  > bits in #ifdef (urgh), what really is the more elegant way of doing it?
> 
> Doing the CONFIG_X86_LOCAL_APIC definition earlier.

... so simple it hurts ...

-- 
http://function.linuxpower.ca
		


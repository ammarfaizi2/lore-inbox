Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288144AbSACCih>; Wed, 2 Jan 2002 21:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288145AbSACCi2>; Wed, 2 Jan 2002 21:38:28 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:22035 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S288144AbSACCiS>;
	Wed, 2 Jan 2002 21:38:18 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15411.49911.958835.299377@argo.ozlabs.ibm.com>
Date: Thu, 3 Jan 2002 13:33:27 +1100 (EST)
To: Richard Henderson <rth@redhat.com>
Cc: Tom Rini <trini@kernel.crashing.org>, jtv <jtv@xs4all.nl>,
        Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020102160739.A10659@redhat.com>
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102133632.C10362@redhat.com>
	<20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102232320.A19933@xs4all.nl>
	<20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020103004514.B19933@xs4all.nl>
	<20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net>
	<20020102160739.A10659@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson writes:

> Ignore strcpy.  Yes, that's what visibly causing a failure here,
> but the bug is in the funny pointer arithmetic.  Leave that in
> there and the compiler _will_ bite your ass sooner or later.

I look forward to seeing your patch to remove all uses of
virt_to_phys, phys_to_virt, __pa, __va, etc. from arch/alpha... :)

Paul.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288061AbSACAWO>; Wed, 2 Jan 2002 19:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288064AbSACAUg>; Wed, 2 Jan 2002 19:20:36 -0500
Received: from mxzilla2.xs4all.nl ([194.109.6.50]:10511 "EHLO
	mxzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S288054AbSACAUH>; Wed, 2 Jan 2002 19:20:07 -0500
Date: Thu, 3 Jan 2002 01:20:04 +0100
From: jtv <jtv@xs4all.nl>
To: Richard Henderson <rth@redhat.com>, Tom Rini <trini@kernel.crashing.org>,
        Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020103012004.E19933@xs4all.nl>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl> <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103004514.B19933@xs4all.nl> <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102160739.A10659@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020102160739.A10659@redhat.com>; from rth@redhat.com on Wed, Jan 02, 2002 at 04:07:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 04:07:39PM -0800, Richard Henderson wrote:
> On Wed, Jan 02, 2002 at 05:01:18PM -0700, Tom Rini wrote:
> > Yes, but doesn't -ffreestanding imply that gcc _can't_ assume this is
> > the standard library...
> 
> Ignore strcpy.  Yes, that's what visibly causing a failure here,
> but the bug is in the funny pointer arithmetic.  Leave that in
> there and the compiler _will_ bite your ass sooner or later.

Thank you for taking it all and putting it in a nutshell.


Jeroen


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262374AbRERQXx>; Fri, 18 May 2001 12:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262375AbRERQXn>; Fri, 18 May 2001 12:23:43 -0400
Received: from spc.esa.lanl.gov ([128.165.46.232]:15242 "HELO spc.esa.lanl.gov")
	by vger.kernel.org with SMTP id <S262374AbRERQXb>;
	Fri, 18 May 2001 12:23:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: Jes Sorensen <jes@sunsite.dk>, esr@thyrsus.com
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Date: Fri, 18 May 2001 10:22:33 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch>
In-Reply-To: <d3wv7eptuz.fsf@lxplus015.cern.ch>
MIME-Version: 1.0
Message-Id: <0105181022330G.10237@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 May 2001 09:19, Jes Sorensen wrote:
> Replacing the code does not require changing the style of the config
> files. Thats a major problem with CML2, you introduce a new 'let me do
> everything for you' tool that relies on a programming language that is
> not being shipped by any major vendor nor does it look like they are
> planning to do it anytime soon. And even if they start doing so, this

Actually, Linux-Mandrake 8.0 ships with Python 2.0, but your next
point is a very good one:

> is a totally unreasonable requirement, you *must* to make it possible
> to compile kernels on older distributions without requiring people to
> update half of their system. On some architectures, the majority of
> the users are still on glibc 2.0 and other old versions of
> tools. Telling them to install an updated gcc for kernel compilation
> is a necessary evil, which can easily be done without disturbing the
> rest of the system. Updating the system's python installation is not a
> reasonable request. Nobody disagrees that the Makefiles needs a
> redesign, however that doesn't mean everything else has to be
> redisigned in a totally incompatible manner.

I didn't have trouble installing python 2.0 before LM 8.0 did that for me,
but I was probably just lucky.  I've seen some reports by other people who
did have difficulty upgrading python.  If the python installation difficulties
are a real obstacle, perhaps that is what needs to be fixed.

Steven

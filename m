Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268837AbRHFQK6>; Mon, 6 Aug 2001 12:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268841AbRHFQKs>; Mon, 6 Aug 2001 12:10:48 -0400
Received: from [216.230.83.4] ([216.230.83.4]:32275 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S268837AbRHFQKk>;
	Mon, 6 Aug 2001 12:10:40 -0400
From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: fsync() on directories (was Re: ext3-2.4-0.9.4)
In-Reply-To: <01080317471707.01827@starship> <20010803121638.A28194@cs.cmu.edu>
	<0108031854120A.01827@starship>
	<Pine.LNX.4.33L.0107301320370.11893-100000@imladris.rielhome.conectiva>
	<s5gvgkacqlm.fsf@egghead.curl.com>
	<200107301711.f6UHBWHE001945@acap-dev.nas.cmu.edu>
	<20010803132457.A30127@cs.cmu.edu> <s5g3d78261g.fsf@egghead.curl.com>
	<20010804051320.B16516@emma1.emma.line.org>
	<s5gr8usmqkg.fsf@egghead.curl.com>
	<20010804062927.K16516@emma1.emma.line.org>
Date: 06 Aug 2001 12:10:22 -0400
In-Reply-To: <20010804062927.K16516@emma1.emma.line.org>
Message-ID: <s5gd769tbip.fsf_-_@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are the Linux "fsync() the directory" semantics documented anywhere?
I mean other than in the source code and on mailing lists.

It might be easier to convince MTA authors to support these semantics
if there were an "official" document describing them and giving some
guarantee that Linux will contine to support them in the future.  It
would be nice to see this described in linux/Documentation or in the
fsync() man page or both.  Without this, it is hard for a software
author to know that Linux's behavior here is not just an
implementation artifact.

 - Pat

P.S.  Is fdatasync() on a directory guaranteed to do anything?  Just
curious.

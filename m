Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285426AbRLSTlN>; Wed, 19 Dec 2001 14:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285428AbRLSTlD>; Wed, 19 Dec 2001 14:41:03 -0500
Received: from fw.aub.dk ([195.24.1.194]:35712 "EHLO Princess")
	by vger.kernel.org with ESMTP id <S285426AbRLSTkq>;
	Wed, 19 Dec 2001 14:40:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Allan Sandfeld <linux@sneulv.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: On K7, -march=k6 is good (Was Re: Why no -march=athlon?)
Date: Wed, 19 Dec 2001 20:38:41 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com> <20011219175616.GD19236@0xd6.org> <x88itb3njfr.fsf@rpppc1.hns.com>
In-Reply-To: <x88itb3njfr.fsf@rpppc1.hns.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16GmY5-0000F5-00@Princess>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 December 2001 19:39, nbecker@fred.net wrote:
> >>>>> "M" == M R Brown <mrbrown@0xd6.org> writes:
>
>     M> Curious, what happens when you compile using gcc 3.0.1 against
>     M> -march=athlon?
>
> Is it safe to use gcc-3.0.2 to compile the kernel?
>
If it compiles.. Otherwise use gcc-3.0.3(prerelease), it has fixes that makes 
the _current_ kernel compile. 
<sarcasm> 
Obviously it's still full of bugs, it wouldn't really be gcc if it wasn't.
</sarcasm>

I am currently running a linux-2.4.16-gcc3, where the only changed part is 
the use of the gcc-3.0 compiler, and a -foptimize-siblings-calls flag. It's 
running smoothly, although I havn't done any performance test yet.

Btw. I havent found anything that compiles with gcc-3.1 yet.

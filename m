Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSHYGyJ>; Sun, 25 Aug 2002 02:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSHYGyI>; Sun, 25 Aug 2002 02:54:08 -0400
Received: from cttsv008.ctt.ne.jp ([210.166.4.137]:55180 "EHLO
	cttsv008.ctt.ne.jp") by vger.kernel.org with ESMTP
	id <S317017AbSHYGyI>; Sun, 25 Aug 2002 02:54:08 -0400
Message-Id: <200208250657.PAA11049@cttsv008.ctt.ne.jp>
Date: Sun, 25 Aug 2002 08:50:44 +0900
To: Thunder from the hill <thunder@lightweight.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Tomas Szepe <szepe@pinerecords.com>
From: Kerenyi Gabor <wom@tateyama.hu>
Subject: Re: [RFC] make localconfig
Organization: Tateyama Hungary Ltd.
X-Mailer: Opera 5.12 build 932
X-Priority: 3 (Normal)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8/24/2002 11:12:46 PM, Thunder from the hill <thunder@lightweight.ods.org> wrote:

>	Generate a .config for the local computer, so that the kernel 
>	could be built right in that moment. Therefor the local computer 
>	is being examined, probed and configured and all the devices that
>	we find go into your .config.
>
>	The version is probably never 100% accurate, it might be a good 
>	idea to manually recheck the .config (e.g. via make menuconfig)
>
>	This is supposed to be a first step into a new direction where 
>	we no longer copy vendor kernels from the vendor CD to the system 
>	in the first position, but rather configure a new kernel for each 
>	system, hoping that somewhen the boxes will be fast enough to 
>	handle it in no time.

I disagree. It can't make things better or faster if you have to recheck the
.config file manually. When you are going through the checking part you
could just easily set the options too.
People compiling kernel know their machine and they also know what and
where must be set in the menuconfig. By the way there are a lot of machine
independent things that can't be discovered using a script, like network
options, preemption, filesystems etc. So users would have to set these
things at least and at this point I can't see how it could save time for me.
Nobody knows better than me what my computer has or what I want to see
compiled in the kernel. I think it would make things less reliable and instead
of saving time it would add extra check/time and work.

On the other hand it would be a great first step towards to have a full or almost
full automated kernel compilation for those who don't know enough or anything
about their computers or they don't have the necessary skills. Sooner or later
there will be a demand for it. Just think about avarage programmers. They now
just set up their M$ thing and start writing programs without the knowladge of
computers or deeper level of operating systems. They see only source codes of
THEIR programs and therefore they run into trouble if a hardware/driver problem
arises. (Of course I disagree with this kind of behavior) It could be useful for
this case, not for saving time.
And these people are not the ones without any computer skills. They have just
chosen another field in computer science.

Gabor



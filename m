Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbSKSRm3>; Tue, 19 Nov 2002 12:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSKSRm3>; Tue, 19 Nov 2002 12:42:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52309 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267029AbSKSRm1>; Tue, 19 Nov 2002 12:42:27 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
References: <Pine.LNX.4.44.0211190930400.25643-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2002 10:48:46 -0700
In-Reply-To: <Pine.LNX.4.44.0211190930400.25643-100000@home.transmeta.com>
Message-ID: <m1wun9zc01.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Tue, 19 Nov 2002, Dave Hansen wrote:
> > 
> > I have a couple of ideas.  But, first, is it hard to reconstruct the 
> > memory map?
> 
> Hmm.. You shouldn't need to reconstruct it. It's all there in the
> 
> 	struct e820map e820;
> 
> (yeah, we will have modified it to match the setup of the running kernel, 
> but on the whole it should all be there, no?)

Yep.  We just need to get that information out to user space.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbSKSR0c>; Tue, 19 Nov 2002 12:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbSKSR0c>; Tue, 19 Nov 2002 12:26:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:270 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266971AbSKSR0b>; Tue, 19 Nov 2002 12:26:31 -0500
Date: Tue, 19 Nov 2002 09:33:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
In-Reply-To: <3DDA65B7.8070703@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0211190930400.25643-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Nov 2002, Dave Hansen wrote:
> 
> I have a couple of ideas.  But, first, is it hard to reconstruct the 
> memory map?

Hmm.. You shouldn't need to reconstruct it. It's all there in the

	struct e820map e820;

(yeah, we will have modified it to match the setup of the running kernel, 
but on the whole it should all be there, no?)

		Linus


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130773AbRCEXbc>; Mon, 5 Mar 2001 18:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130774AbRCEXbW>; Mon, 5 Mar 2001 18:31:22 -0500
Received: from jalon.able.es ([212.97.163.2]:32408 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130773AbRCEXbJ>;
	Mon, 5 Mar 2001 18:31:09 -0500
Date: Tue, 6 Mar 2001 00:30:56 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Sergey Kubushin <ksi@cyberbills.com>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
Message-ID: <20010306003056.C1136@werewolf.able.es>
In-Reply-To: <20010305235629.A1136@werewolf.able.es> <Pine.LNX.4.31ksi3.0103051507140.12620-100000@nomad.cyberbills.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.31ksi3.0103051507140.12620-100000@nomad.cyberbills.com>; from ksi@cyberbills.com on Tue, Mar 06, 2001 at 00:13:24 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.06 Sergey Kubushin wrote:
> On Mon, 5 Mar 2001, J . A . Magallon wrote:
> 
> > What that line does is to build a tool (aicasm) to generate the ucode
> > that
> > is built into the kernel (afaik, it is a kind of assembler from a
> > language
> > to AIC sequencer code). That is, the tool uses db1 (as mkdep.c uses
> > glibc)
> > but once you have generated the sequencer instructions, that is what is
> > built
> > into the kernel, not the tool (aicasm).
> 
> It's very nice... Now one should have not only special kgcc to build the
> kernel, but also the obsolete library with all the development stuff
> installed... Is it sane?
> 

What I dunno is why the h... is needed to rebuild the code everytime you build
a kernel. Just ship the ucode and remove the aicasm subtree from kernel.
Perhaps mrproper makes things too clean, and just should leave there the
sequencer code.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac11 #1 SMP Sat Mar 3 22:18:57 CET 2001 i686


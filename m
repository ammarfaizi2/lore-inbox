Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278700AbRJXSR4>; Wed, 24 Oct 2001 14:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278701AbRJXSRp>; Wed, 24 Oct 2001 14:17:45 -0400
Received: from Expansa.sns.it ([192.167.206.189]:37380 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S278700AbRJXSRa>;
	Wed, 24 Oct 2001 14:17:30 -0400
Date: Wed, 24 Oct 2001 20:11:51 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "J . A . Magallon" <jamagallon@able.es>
cc: David Lang <david.lang@digitalinsight.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM
In-Reply-To: <20011024155456.A6773@werewolf.able.es>
Message-ID: <Pine.LNX.4.33.0110242007330.1991-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UGLY!
two VM is one kernel is a nonsense. To develop an OS you have to do also
choices like this. I already wrote what i think of those VMs, they
are both usefull, but with different conditions and with different
worksload and HWs, depending on the behaviour you need.
Rik and Andrea know my point of view, I need a predictable VM for mission
critical USE, on desktop people will need the fastest VM for low memory
systems.
But to manage the development implys a choice, that could be different
for different branches, but anyway someone has to say, "This is the
right VM for this kernel, for what I think this kernel should
do"!

Luigi


On Wed, 24 Oct 2001, J . A . Magallon wrote:

>
> On 20011023 David Lang wrote:
> >Daniel, I think the suggestion isn't to break out the differences in a
> >bunch of config options, but rather to do something like duplicating all
> >files that are VM related into two files, foo.c becomes foo.aa.c and
> >foo.rik.c at that point your config file either uses all the .rik files or
> >all the .aa files and both would be in the same tree, but not interact
> >with each other.
> >
>
> Could it be as simple as duplicating linux/mm subtree to mm-aa and mm-rik,
> and symlinking based on a CONFIG_ option ? Or are there any other touched
> files apart from that subtree ?
>
> Or just adding separate config options, *config-aa and *config-rik,
> that make the symlink and call *config ?
>
> --
> J.A. Magallon                           #  Let the source be with you...
> mailto:jamagallon@able.es
> Mandrake Linux release 8.2 (Cooker) for i586
> Linux werewolf 2.4.12-ac6-beo #1 SMP Tue Oct 23 21:24:30 CEST 2001 i686
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279566AbRJXNyC>; Wed, 24 Oct 2001 09:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279567AbRJXNxw>; Wed, 24 Oct 2001 09:53:52 -0400
Received: from jalon.able.es ([212.97.163.2]:36234 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S279566AbRJXNxs>;
	Wed, 24 Oct 2001 09:53:48 -0400
Date: Wed, 24 Oct 2001 15:54:56 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: David Lang <david.lang@digitalinsight.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM
Message-ID: <20011024155456.A6773@werewolf.able.es>
In-Reply-To: <20011023161446Z16332-4006+621@humbolt.nl.linux.org> <Pine.LNX.4.40.0110230911110.12990-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.40.0110230911110.12990-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Tue, Oct 23, 2001 at 18:14:03 +0200
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011023 David Lang wrote:
>Daniel, I think the suggestion isn't to break out the differences in a
>bunch of config options, but rather to do something like duplicating all
>files that are VM related into two files, foo.c becomes foo.aa.c and
>foo.rik.c at that point your config file either uses all the .rik files or
>all the .aa files and both would be in the same tree, but not interact
>with each other.
>

Could it be as simple as duplicating linux/mm subtree to mm-aa and mm-rik,
and symlinking based on a CONFIG_ option ? Or are there any other touched
files apart from that subtree ?

Or just adding separate config options, *config-aa and *config-rik,
that make the symlink and call *config ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.12-ac6-beo #1 SMP Tue Oct 23 21:24:30 CEST 2001 i686

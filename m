Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262679AbVCWA5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVCWA5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVCWA5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:57:19 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:29375 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262679AbVCWAz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:55:59 -0500
From: Grant Coady <grant_nospam@dodo.com.au>
To: Diego Calleja <diegocg@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Date: Wed, 23 Mar 2005 11:55:51 +1100
Organization: scattered.homelinux.net
Message-ID: <3ue141ho6ekruos112pgphbo6p1sruiml2@4ax.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <20050314191230.3eb09c37.diegocg@gmail.com> <1110827273.14842.3.camel@mindpipe> <20050323013729.0f5cd319.diegocg@gmail.com>
In-Reply-To: <20050323013729.0f5cd319.diegocg@gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2005 01:37:29 +0100, Diego Calleja <diegocg@gmail.com> wrote:

>El Mon, 14 Mar 2005 14:07:53 -0500,
>Lee Revell <rlrevell@joe-job.com> escribió:
>
>> I'm really not trolling, but I suspect if we made the boot process less
>> verbose, people would start to wonder more about why Linux takes so much
>> longer than XP to boot.
>
>By the way, Microsoft seems to be claiming that boot time will be reduced to the half
>with Longhorn. While we already know how ms marketing team works, 50% looks
>like a lot. Is there a good place to discuss what could be done in the linuxland to
>improve things? It doesn't looks like a couple of optimizations will be enought...

Considering msft don't do full options hardware detection until 
after GUI shell is up, next speed up could simply be start from 
hibernate?  They already do a hardware signature, and if hardware 
changed you may need a new license anyway :-)  Pay per cold boot?


Noisy startup?  2.6 has good solution in default kernel build, 
display milestones during startup or super quiet loader option 
passed from boot?  "dmesg -qq" thru "dmesg -vv" stir anyone?

Grant.


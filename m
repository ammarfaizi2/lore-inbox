Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbTABRyK>; Thu, 2 Jan 2003 12:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbTABRyK>; Thu, 2 Jan 2003 12:54:10 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:2564 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S266270AbTABRyJ>;
	Thu, 2 Jan 2003 12:54:09 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200301021856.0040@gandalf>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Fix kallsyms crashes in 2.5.54
Date: Thu, 2 Jan 2003 19:02:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
References: <20030102091325.GA24352@averell> <3E1427FD.16A7B021@digeo.com> <20030102120033.GA4266@averell>
In-Reply-To: <20030102120033.GA4266@averell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 January 2003 13:00, Andi Kleen wrote:
> On Thu, Jan 02, 2003 at 12:52:29PM +0100, Andrew Morton wrote:
> > Andi Kleen wrote:
> > > 
> > > The kernel symbol stem compression patch included in 2.5.54 
unfortunately
> > > had a few problems, triggered by various circumstances.
> > > 
> > 
> > With your patch I am still seeing an instant oops when running top(1):
> 
> Did you make sure the .tmp_kallsym* files in your kernel build were
> regenerated ? 

applied Andi's patch, did a make mrproper and rebuild kernel, but it crashes 
when I run ps (2.0.11 from http://surriel.com/procps/) no oops, nothing in 
logs and I'm unable to switch consoles

without the patch it resulted in a crash with filesystem corruption (ext2)

	Rudmer

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129962AbRAEBYF>; Thu, 4 Jan 2001 20:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130110AbRAEBXz>; Thu, 4 Jan 2001 20:23:55 -0500
Received: from jalon.able.es ([212.97.163.2]:49537 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129962AbRAEBXm>;
	Thu, 4 Jan 2001 20:23:42 -0500
Date: Fri, 5 Jan 2001 02:23:35 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Message-ID: <20010105022335.E743@werewolf.able.es>
In-Reply-To: <3A54DC87.5B861B7@goingware.com> <m37l4akdn5.fsf@austin.jhcloos.com> <20010105021623.C743@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010105021623.C743@werewolf.able.es>; from jamagallon@able.es on Fri, Jan 05, 2001 at 02:16:23 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.05 J . A . Magallon wrote:
> 
> > 
> > Either way you need the userspace daemon running to actually do
> > anything.  Even my notebook's key for toggling full-screen vs
> > un-expanded display on the lcd does nothing unless apmd or acpid
> > as applicable are running....
> > 

I forgot it. If you just want to power-off:
- activate APM in the BIOS
- activate APM in kernel

I have an SMP box, so APM does not work fully, but just power-off works.
So if for any reason you box says is not capable of doing APM, add this
to lilo.conf:
append="apm=power-off"
so at least this will work.

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre6 #1 SMP Wed Jan 3 21:28:10 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

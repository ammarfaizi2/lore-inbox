Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSGSUnb>; Fri, 19 Jul 2002 16:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316959AbSGSUnb>; Fri, 19 Jul 2002 16:43:31 -0400
Received: from [209.184.141.189] ([209.184.141.189]:53999 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S315451AbSGSUna>;
	Fri, 19 Jul 2002 16:43:30 -0400
Subject: Re: 2.4 O(1) scheduler
From: Austin Gonyou <austin@digitalroadkill.net>
To: anton wilson <anton.wilson@camotion.com>
Cc: J Sloan <jjs@lexus.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200207192018.QAA19141@test-area.com>
References: <200207191943.PAA00351@test-area.com>
	 <3D386E70.4040401@lexus.com>  <200207192018.QAA19141@test-area.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 19 Jul 2002 15:46:27 -0500
Message-Id: <1027111587.6685.24.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Been using 2.4.19-rc1-aa2 on a fairly large x86 box for about 16 days
now. Nothing but love. Using the 0/1 scheduler, though I'm not sure if I
could tweak it for "better" performance.(hint: like to see some
"best-practices" type of doc, for 4/8-way SMP boxen)

Aside from that, I've got 8GB ram, a ~750GB Oracle instance running, and
4GB SHMMAX attatched to some Copper FC1 disks and using QLA2200's. 

It's been very happy since rc1. Anyway, it's worth a shot. As soon as
2.4.19 is "done" this box will go into production as soon as this RC2 VM
stuff is cleared up.


On Fri, 2002-07-19 at 15:17, anton wilson wrote:
> On Friday 19 July 2002 03:54 pm, J Sloan wrote:
> > Use 2.4-aa, 2.4-ac or 2.4-redhat kernel
> > and you get the O(1) secheduler at
> > no extra cost -
> >
> 
> 
> > Joe
> 
> 
> I'm actually worried not about just the O(1) scheduler but if these patches 
> will be incorporating the O(1) bug fixes such as the serious one in 
> balance_load where curr->next was used instead of current->prev. Also, I need 
> to use a patch that won't tamper with the usb implementation because I'd have 
> to update our current usb driver to fit into the new system, and I'm getting 
> flack about wasting time trying to update that thing already . . . So if you 
> tell me no, I can go tell my boss I have to update the usb driver.
> 
> 
> Anton
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>

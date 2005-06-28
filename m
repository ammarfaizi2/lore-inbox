Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVF1VpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVF1VpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVF1Voh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:44:37 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:11195 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261630AbVF1Vlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:41:53 -0400
Message-Id: <200506282141.j5SLfZbH010128@laptop11.inf.utfsm.cl>
To: Howard Owen <hbo@egbok.com>
cc: LKML List <linux-kernel@vger.kernel.org>
Subject: Re: Newbie Roadmap? 
In-Reply-To: Message from Howard Owen <hbo@egbok.com> 
   of "Mon, 27 Jun 2005 11:20:32 MST." <1119896432.9541.88.camel@Quirk.egbok.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 28 Jun 2005 17:41:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 28 Jun 2005 17:41:36 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Owen <hbo@egbok.com> wrote:
> I've embarked on a project to write device drivers for an obscure and
> rare ISA card. It's a modern version of the HP 82973 HP-IL interface
> produced by Cristoph Klug. HP-IL was a bit-serial, dog-slow version of
> HP-IB (IEEE-488) that was designed to work with the HP-41C family of
> calculators, and later with the HP-71 and HP-85. The 41C calculators are
> my hobby interest. I'd like to introduce myself, and ask for pointers
> for a newbie device driver author.

As you say later you have stuff working in userland under DOSEMU (and the
"dog slow" part), I'd suggest a userspace driver. It is probably easier to
work with, and has the advantage that you can run it under the bog-standard
$DISTRO kernel with some care, no patching/reconfiguring/rebuilding to be
done.

[No, I'm just an old hand here; no expert of any sort. Good luck!]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

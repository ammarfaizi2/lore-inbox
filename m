Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTLGWLV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 17:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTLGWLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 17:11:21 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:40974
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S264535AbTLGWLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 17:11:17 -0500
Date: Sun, 7 Dec 2003 23:10:56 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Michal Jaegermann <michal@harddata.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Message-ID: <20031207221056.GA2990@man.beta.es>
References: <20031130214612.GP2935@mail.muni.cz> <200311301728.10563.dtor_core@ameritech.net> <20031130223953.GR2935@mail.muni.cz> <200311301826.52978.dtor_core@ameritech.net> <20031130202521.A30370@mail.harddata.com> <20031207194404.GC13201@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207194404.GC13201@mail.muni.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I didn't notice this thread till now...

> But why it does not hurt with kernel 2.4.22? Moreover how ACPI BIOS influences
> synaptics driver? I do not see any BIOS call there...

I have this problem reported as bug 1093 at bugme.osdl.org, my laptop is an
ACER with intel chipset.

The problem will happen even if you only check the batery status once a day,
at that time, you can get the lost sync thing in 2.6, but not in 2.2, so the
problem is not with the gnome applet, in fact I'm seing it under icewm and I
have been able to reproduce it without any battery applet or anything like
that, only running the "acpi -V" command each minute in a cron, that
suffices for getting the errors.

I believe that this should be solved, in 2.6, as it certainly doesn't happen
on 2.4, if you want more info look at bug #1093 at bugme.osdl.org or if you
need more details just ask for them.

Hope this helps.

Regards...
-- 
Manty/BestiaTester -> http://manty.net

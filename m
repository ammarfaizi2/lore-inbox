Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278069AbRJOUXG>; Mon, 15 Oct 2001 16:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278072AbRJOUW4>; Mon, 15 Oct 2001 16:22:56 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:9994 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S278069AbRJOUWu>; Mon, 15 Oct 2001 16:22:50 -0400
Date: Mon, 15 Oct 2001 22:23:11 +0200
From: christophe barbe <christophe.barbe.ml@online.fr>
To: "Justin T . Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export pci_table in aic7xxx for Hotplug
Message-ID: <20011015222311.E2665@turing>
In-Reply-To: <20011015195934.C2665@turing> <200110151902.f9FJ22Y52786@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <200110151902.f9FJ22Y52786@aslan.scsiguy.com>; from gibbs@scsiguy.com on lun, oct 15, 2001 at 21:02:02 +0200
X-Mailer: Balsa 1.2.pre3
X-Operating-System: debian SID Gnu/Linux 2.4.12 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have defined __NO_VERSION__ before including module.h because in my
understanding this is required when you include it in a multi-files module.
Only one file must include module.h without defining the __NO_VERSION__.

I remember to read something about a repository for your new driver. Please
could you point it to me and I will try it ASAP.

Thanks,
Christophe 

Le 2001.10.15 21:02:02 +0200, Justin T. Gibbs a écrit :
> >Attached to this mail is a patch (against 2.4.12) that export the PCI
> table
> >for the hotplug code (via modules.pcimaps).
> >
> >I use it succesfully with my Adaptec APA1480A cardbus and the hotplug
> code.
> 
> Does the code in v6.2.4 of the aic7xxx driver work for you?  Other than
> the "__NO_VERSION__" stuff (which I'll have to look into), it seems
> identical to what is in that version of the driver.
> 
> --
> Justin
> 
-- 
Christophe Barbé <christophe.barbe@online.fr>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

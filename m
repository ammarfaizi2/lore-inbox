Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVFEH1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVFEH1d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 03:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVFEH1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 03:27:33 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:23465 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261493AbVFEH12 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 03:27:28 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
Date: Sun, 5 Jun 2005 02:27:24 -0500
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Zoltan Boszormenyi <zboszor@freemail.hu>,
       Sid Boyce <sboyce@blueyonder.co.uk>
References: <42A2A0B2.7020003@freemail.hu> <42A2A657.9060803@freemail.hu> <20050605001001.3e441076.akpm@osdl.org>
In-Reply-To: <20050605001001.3e441076.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506050227.25378.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 June 2005 02:10, Andrew Morton wrote:
> Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
> >
> > Zoltan Boszormenyi írta:
> > > Hi,
> > > 
> > > $SUBJECT says almost all, system is MSI K8TNeo FIS2R,
> > > Athlon64 3200+, running FC3/x86-64. I use the multiconsole
> > > extension from linuxconsole.sf.net, the patch does not touch
> > > anything relevant under drivers/input or drivers/usb.
> > > 
> > > The mice are detected just fine but the mouse pointers
> > > do not move on either of my two screens. The same patch
> > > (not counting the trivial reject fixes) do work on the
> > > 2.6.11-1.14_FC3 errata kernel. Both PS2 keyboard on the
> > > keyboard and aux ports work correctly.
> > 
> > The same patch also works on 2.6.12-rc4-mm2, with working mice.
> > It seems the bug is mainstream.
> > 
> 
> Please test an unpatched kernel.

I think it is the same problem as Sid is seeing on his box.

> I attached dmesg and the contents of /proc/interrupts.
> The interrupt count on USB does not increase if I move either
> mouse.
> 

Sid, if you move mouse on your box, do you see interrupts reported
in /proc/interrupts? Do you also have x86-64?

-- 
Dmitry

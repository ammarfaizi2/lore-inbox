Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVCCDmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVCCDmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVCCB6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:58:02 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:43952 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261367AbVCCBnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:43:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: David Johnson <dj@david-web.co.uk>
Subject: Re: Keyboard broken on Inspiron 5150 with 2.6.11
Date: Wed, 2 Mar 2005 20:43:35 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200503022135.16575.dj@david-web.co.uk> <d120d50005030214037e7531cb@mail.gmail.com> <200503022233.12913.dj@david-web.co.uk>
In-Reply-To: <200503022233.12913.dj@david-web.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503022043.35777.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 17:33, David Johnson wrote:
> On Wednesday 02 Mar 2005 22:03, Dmitry Torokhov wrote:
> > On Wed, 2 Mar 2005 21:35:16 +0000, David Johnson <dj@david-web.co.uk> wrote:
> > > Hi all,
> > >
> > > I've just booted 2.6.11 and the keyboard on my Dell Inspiron 5150 laptop
> > > doesn't work at all. I've not tried the -rc versions, but it works fine
> > > with 2.6.10.
> >
> > Does it work if you boot with i8042.noacpi boot option? And what about
> > your touchpad?
> 
> Ah yes, it works perfectly with that boot option.
> 

Can you check dmesg for 2.6.11 when booted _without_ i8042.noacpi for
messages from ACPI and i8042 please? Do you see something like following:

> ACPI: PS/2 Keyboard Controller [KBC] at I/O 0x60, 0x66, irq 1
> ACPI: PS/2 Mouse Controller [PS2M] at irq 12
> i8042.c: Can't read CTR while initializing i8042.


-- 
Dmitry

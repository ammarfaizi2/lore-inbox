Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbRLaRWB>; Mon, 31 Dec 2001 12:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287577AbRLaRVw>; Mon, 31 Dec 2001 12:21:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26381 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287571AbRLaRVg>;
	Mon, 31 Dec 2001 12:21:36 -0500
Message-ID: <3C309E9C.A3BB27E4@mandrakesoft.com>
Date: Mon, 31 Dec 2001 12:21:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Fabio Tudone <ftudone@libero.it>, hpa@zytor.com
Subject: Re: IRQ assignment probs with "1st Supersonic M6T Gericom" laptop
In-Reply-To: <Pine.LNX.4.33.0112311810070.1366-100000@vaio>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> 
> On Mon, 31 Dec 2001, Fabio Tudone wrote:
> 
> > The basic problem is that I've been able to get interrupts assigned to the
> > peripherals  _only_ booting into Windows 2000 (other Windows versions won't
> > do the trick) _from poweroff_ and then booting into Linux (I think that in
> > fact it's a broken BIOS problem, but there are no upgrades available yet).
> 
> Yes, the BIOS provided $PIR table seems broken.
> 
> It would be nice if you could try whether ACPI IRQ routing works for you.
> 
> To do so, get the latest ACPI (20011218) source release, from
> www.sf.net/projects/acpi and apply it to 2.4.17. Then, apply the appended
> patch.

To tangent, I think it would be useful to allow the bootloader to load
ACPI or $PIR or MP tables, in case someone is cutting costs [no tables]
or broken BIOS [replacement of broken tables].

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

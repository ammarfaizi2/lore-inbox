Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132763AbRC2QSX>; Thu, 29 Mar 2001 11:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132764AbRC2QSN>; Thu, 29 Mar 2001 11:18:13 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:43802 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132763AbRC2QRx>; Thu, 29 Mar 2001 11:17:53 -0500
Date: Thu, 29 Mar 2001 11:16:21 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3-p8 pci_fixup_vt8363 + ASUS A7V "Optimal" = IDE disk corruption
Message-ID: <20010329111621.A23751@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.30.0103281942010.12066-100000@mf1.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0103281942010.12066-100000@mf1.private>; from whitney@math.berkeley.edu on Wed, Mar 28, 2001 at 09:29:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 09:29:46PM -0800, Wayne Whitney wrote:

> I'm running kernel 2.4.3-pre8 on an ASUS A7V (BIOS 1007) motherboard and
> recently noticed that it sometimes corrupts my hard disk, an IBM 75GXP on
> the onboard PDC20265 IDE controller.  The corruption is detectable with a
> simple 'dd if=/dev/urandom of=test bs=16384 count=32768; cp test test2 ;
> diff test test2'.


/me throws arms in the air in despiration
It seems that the exact same settings corrupt a lot on one board and not on
another. But if you remove the quirk, the corruption is the
other way around........ 

Greetings,
  Arjan van de Ven


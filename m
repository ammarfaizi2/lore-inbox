Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265546AbRFVWQ4>; Fri, 22 Jun 2001 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265545AbRFVWQq>; Fri, 22 Jun 2001 18:16:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24334 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265541AbRFVWQa>; Fri, 22 Jun 2001 18:16:30 -0400
Subject: Re: ACPI + Promise IDE = disk corruption :-(((
To: proski@gnu.org (Pavel Roskin)
Date: Fri, 22 Jun 2001 23:16:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106221635230.1575-100000@vesta.nine.com> from "Pavel Roskin" at Jun 22, 2001 05:07:02 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DZDd-0004Fq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I enabled ACPI in 2.4.5-ac17 (2.4.5-ac16 works fine with the same config
> except ACPI). When I booted I saw a message

> I hit reset hoping to boot the system with "acpi=no-idle", but GRUB
> couldn't load stage2, which resides on the root partition (reiserfs).

I've seen several people report ACPI eats disks. ACPI is incredibly complex
badly designed crud. My advice is never use ACPI. This incidentally appears
to be the advice Microsoft give people too - they tell people to disable
ACPI as one of the first steps to diagnosing strange crashes in machines

ACPI is over complex, new technology. The BIOS stuff is new (and frequently
wrong), the kernel stuff is new (and has plenty of known bugs) and the 
combination is a recipe for disaster.

I've been discussing with a few folk about doing an alternative mini acpi
subset so that Linux can be booted on most 'ACPI only' hardware without 
using all the ACPI junk

Alan


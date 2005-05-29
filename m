Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVE2R1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVE2R1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 13:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVE2R1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 13:27:14 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:47286 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261225AbVE2R1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 13:27:06 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <4299F47B.5020603@gmail.com>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299F47B.5020603@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 19:26:31 +0200
Message-Id: <1117387591.4851.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-29 at 18:57 +0200, Michael Thonke wrote:

> >Another question: is there a fundamental problem to have the ICH6/7
> >enabled AHCI mode by the kernel instead of the BIOS? I know some BIOSes
> >don't offer the choice to enable AHCI (like mine :-().

> here on my Mainboard ASUS P5WAD2-Premium (i955X/ICH7) I need to enable
> AHCI support like on the ICH6R based ASUS P5AD2-E xx the same here.
> What I have noticed is when I enable Intel Raid support AHCI is on by
> default, maybe it used AHCI if drive is capable?!

AHCI is needed for "raid"-support.

> What mainboard are you using Erik? All mainboards with ICH6R I saw and
> had (925X,925XE) offer options to enable AHCI.

ICH6M (mobile/no raid) on a Dell Inspiron 9300 laptop. AFAIK there are
no plans to implement support for AHCI transition in the BIOS. &^$##($%
DELL.

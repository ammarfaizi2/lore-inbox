Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292627AbSCIKbj>; Sat, 9 Mar 2002 05:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292629AbSCIKb3>; Sat, 9 Mar 2002 05:31:29 -0500
Received: from infinity.pages.at ([195.58.183.83]:6644 "EHLO raptor.daham")
	by vger.kernel.org with ESMTP id <S292627AbSCIKbW>;
	Sat, 9 Mar 2002 05:31:22 -0500
Message-ID: <3C89E44E.376C5F04@pages.at>
Date: Sat, 09 Mar 2002 11:30:38 +0100
From: Jens Riecken <jens@pages.at>
Organization: PAGES.AT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Promise Supertrack SX6000 problems with kernel 2.4.19-pre2-ac2
In-Reply-To: <004701c1c6f6$37d90af0$ad05c080@chem.uga.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A N Saravanaraj wrote:
> 
> Hi All
> I installed RH 7.2 on a dual PIII serverworks mother board box. It has a
> promise SX6000 card and it was working fine. Then I decided to upgrade the
> kernel to the new version 2.4.18. I down loaded the sources and compiled the
> I2O support as modules. Did the installation of the kernel and the machine
> does not find the I2O card as before and hangs at finding new hardware. Can
> anybody please tell me what I did wrong. And point me to where I can find an
> I2O howto.
> Thank You
> Raj

Hmm, I'm running the SX6000 with both, the i2o support in 2.4.18 (as a
module) and the driver offered by promise, who i informed two days ago
about a small change in their makefile to make it compile with 2.4.18
and modversions.

Just letting the card initialize by it's bios and assigning the
resources at boot time (by choosing OS Other in it's setup) and
inserting i2o_core + i2o_block makes it work fine for me.

HTH

Jens "Iwo" Riecken

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVCHU3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVCHU3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVCHU2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:28:54 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34526 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262270AbVCHURA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:17:00 -0500
Subject: Re: Linux 2.6.11.1
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: gene.heskett@verizon.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110215898.3072.65.camel@localhost.localdomain>
References: <20050304175302.GA29289@kroah.com>
	 <20050305174654.J3282@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0503051316510.2304@ppc970.osdl.org>
	 <200503051649.58709.gene.heskett@verizon.net>
	 <1110060362.12513.48.camel@mindpipe>
	 <1110215898.3072.65.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 15:16:59 -0500
Message-Id: <1110313019.4600.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-07 at 17:18 +0000, Alan Cox wrote:
> On Sad, 2005-03-05 at 22:06, Lee Revell wrote:
> > Driver updates are a hard problem.  Nothing annoys users more than
> > unsupported hardware.  But if you aggressively add support for new
> > devices you can break things that have worked for ages.
> 
> You can however plan for them in advance. Guess why the -ac tree has an
> ide
> option to grab any otherwise unknown ide controller and stuff it in bios
> tuned
> DMA modes ?
> 
> Similarly you can generally apply "just PCI id" patches

Yup.  A much simpler example is my emu10k1 multichannel patches that are
in ALSA CVS now.  The function of an (obscure) mixer control changes
subtly, so the control is renamed to guarantee that the user gets the
default setting.

Lee


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUHKP7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUHKP7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 11:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUHKP7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 11:59:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:60304 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268086AbUHKP7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 11:59:04 -0400
Date: Wed, 11 Aug 2004 08:36:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Diffie <diffie@gmail.com>
Cc: akpm@osdl.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
Message-Id: <20040811083646.3b01813b.rddunlap@osdl.org>
In-Reply-To: <9dda349204081020337de13352@mail.gmail.com>
References: <9dda349204081020337de13352@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 23:33:30 -0400 Diffie wrote:

| Folks,
| 
| 2.6.8-rc4-mm1 panics when booting (aic7xxx) with lots of SCSI ABORT
| and sens code errors.
| IDE ports give also failed probe messages.
| 
| This is on AMD/nForce2 based system under Slackware 10.0 with
| 2.6.8-rc4-mm1 kernel compiled using GCC 3.3.4. Last kernel that worked
| was 2.6.8-rc3-mm1.
| 
| The 2.6.8-rc3-mm2 flag pci=routeirq which Andrew suggested works and
| boots this kernel.
| 
| Below is the full dmesg/lspci output.

Where are the aic7xxx panics?

Please use your kernel boot log message file(s) or
maybe 'dmesg -s100000' to get the complete message log.


--
~Randy

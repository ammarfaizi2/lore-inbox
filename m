Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUAETaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUAETaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:30:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:6325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265238AbUAETaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:30:12 -0500
Date: Mon, 5 Jan 2004 11:30:03 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: 2.6.0 under vmware ?
Message-Id: <20040105113003.1bf558b7.shemminger@osdl.org>
In-Reply-To: <20040105185506.GF11115091@niksula.cs.hut.fi>
References: <1073297203.12550.30.camel@bip.parateam.prv>
	<20040105142032.GE11115091@niksula.cs.hut.fi>
	<20040105185506.GF11115091@niksula.cs.hut.fi>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004 20:55:06 +0200
Ville Herva <vherva@niksula.hut.fi> wrote:

> On Mon, Jan 05, 2004 at 04:20:32PM +0200, you [Ville Herva] wrote:
> >
> > There is one regression, though: 2.2.x and 2.4.x can see /dev/fd0 and
> > /dev/fd1 under vmware. 2.6.1rc1 only find /dev/fd0. Does anyone else see
> > this?
> 
> Turns out the second floppy drive was disabled from the bios.
> 
> Oddly, 2.2 and 2.4 don't care.
> 
> If I turn the second drive on from the bios, 2.6 finds it, too.

Probably because 2.6 uses ACPI and 2.2/2.4 were not.

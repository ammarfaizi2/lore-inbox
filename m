Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265117AbUFAQdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUFAQdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 12:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUFAQ3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 12:29:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:36239 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265128AbUFAQ2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 12:28:34 -0400
Date: Tue, 1 Jun 2004 09:28:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
Message-Id: <20040601092816.18789176@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040531180821.GC5257@louise.pinerecords.com>
References: <40BA2213.1090209@pobox.com>
	<20040530183609.GB5927@pclin040.win.tue.nl>
	<40BA2E5E.6090603@pobox.com>
	<20040530200300.GA4681@apps.cwi.nl>
	<s5g8yf9ljb3.fsf@patl=users.sf.net>
	<20040531180821.GC5257@louise.pinerecords.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004 20:08:21 +0200
Tomas Szepe <szepe@pinerecords.com> wrote:

> > This is really very simple.  If you move a disk from a machine with a
> > different BIOS and you preserve the partition table geometry, you will
> > NEVER be able to install Windows on the drive.  If you partition a
> > blank drive and use the wrong geometry, you will NEVER be able to
> > install Windows on the drive.
> 
> I don't quite believe this.  AFAICT the Windows 2000/XP install program will
> succeed no matter what, the only problem is with getting the dirty thing to
> boot AFTER install has completed.  If it craps out, boot off the install
> CD to the repair console prompt, run fixboot/fixmbr and all should be swell.
> If you need dual boot, you can go ahead and reinstall lilo/grub at this point.
> The one scenario unfixable without a hex editor that I know of is installing
> Windows on a partition that was created using mkdosfs -F 32 (and even that
> will sometimes work)

Having suffered through this "Daddy, why did you break the computer?".
I can say that fixboot/fixmbr will not work. 

What did work on my machine was changing the BIOS setting on the boot disk
from "Auto" to "Large disk".  As I remember there were several possible settings
and it took trying all of them till one worked. Still not sure why it worked
though.


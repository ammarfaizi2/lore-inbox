Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWAaUiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWAaUiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWAaUiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:38:20 -0500
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:48725 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751467AbWAaUiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:38:20 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Lennart Sorensen'" <lsorense@csclub.uwaterloo.ca>,
       "'Sander'" <sander@humilis.net>
Cc: <linux-kernel@vger.kernel.org>, <jgarzik@pobox.com>
Subject: RE: [OT] 8-port AHCI SATA Controller?
Date: Tue, 31 Jan 2006 14:48:41 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20060131185804.GM18970@csclub.uwaterloo.ca>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYml+weYlrhzruVSkedd/hM8b3/wwAD0jNg
Message-ID: <EXCHG2003yL2m9lHiu3000010e0@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 31 Jan 2006 20:31:40.0816 (UTC) FILETIME=[579F6100:01C626A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Lennart Sorensen
> Sent: Tuesday, January 31, 2006 12:58 PM
> To: Sander
> Cc: linux-kernel@vger.kernel.org; jgarzik@pobox.com
> Subject: Re: [OT] 8-port AHCI SATA Controller?
> 
> On Tue, Jan 31, 2006 at 07:50:07PM +0100, Sander wrote:
> > Actually, I need 24 ports :-)  But 3x SX8 sets me back 540 dollars 
> > according to pricewatch, which is less than half.
> 
> I know with older promise controllers, it wasn't possible to 
> run more than 2 in one system as far as I remember due to 
> some dma issues.  Not sure if that applies to the SX8.
> 
> If it turns out the SX8 has issues (like the one pointed out 
> earlier about number of commands to the card at once) or that 
> it can't have 3 cards in one system at once, then what?  Are 
> you then out $540 + the cost of a better controller?  
> Certainly worth finding out before spending the money.
> 
> > Fakeraid controllers are less expensive, and would do too of course 
> > :-)
> 
> Of course those aren't hardware, and are only meant for small 
> toy raids for windows users.  The rest of use treat them as 
> ide/sata controllers only.  I haven't seen one of those with 
> more than 4 ports either.  If the SX8 is one, then I must 
> admit I haven't looked at it before.  I try to avoid hardware 
> from promise whenever possible.
> 

Highpoint has some that I believe are software raidish.

They do have on-board parity generators that are used when
you use there binary only modules.

I have heard that they will work with later kernels (2.6.15+)
since the highpoint are a standard Marvell chipset, and they
seem to be fairly price competitive with JBOD raid controllers,
and have some controllers that have more than 8 ports, the price
per port may be better on the larger controllers.

Using 3 disk software stripe (linux) or 3 disks software stripe
(binary modules) I have got IO rates of 135MB/second sustained
over 90-100 GB read/write tests.

                       Roger


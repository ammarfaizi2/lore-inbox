Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVAXE7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVAXE7e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 23:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVAXE7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 23:59:34 -0500
Received: from ernie.virtualdave.com ([198.216.116.246]:63501 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S261441AbVAXE7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 23:59:32 -0500
Date: Sun, 23 Jan 2005 22:59:29 -0600 (CST)
From: David Sims <dpsims@virtualdave.com>
To: Atul Bhouraskar <atul.bhouraskar@acoustic-technologies.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: irq 3: nobody cared! with Intel 31244 SATA.... Advice??
In-Reply-To: <007201c501c1$fb2c2f60$0d65a8c0@SHARK>
Message-ID: <Pine.LNX.4.21.0501232254160.27074-100000@ernie.virtualdave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atul,

  If I enable APIC on the 2.6.10 kernel I get exactly the same behavior as
I got without APIC.... If I enable APIC-IO, then it starts barking about
Interrupt 22 and never finishes... SO... At the minimum, both of these
settings do not help and one makes the problem worse in that the sata-vsc
module never finishes loading....

  Thanks for your response though... At this point I am ready to climb a
tree and bark at the moon if it will help.... ;)

Dave
************************************************************************
On Mon, 24 Jan 2005, Atul Bhouraskar wrote:

> 
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> > owner@vger.kernel.org] On Behalf Of David Sims
> > Sent: Monday, 24 January 2005 13:57
> > 
> > I then downloaded and built kernel 2.6.10 which boots up fine without
> the
> > sata_vsc module.... If you then load the sata_vsc module manually
> using
> > "modprobe sata_vsc" it will cause the following error once for each
> > attached disk drive:
> > 
> > Jan 23 09:08:21 linux kernel: Disabling IRQ #3
> > Jan 23 09:08:23 linux kernel: irq 3: nobody cared!
> 
> I once had the same problem, I think enabling APIC solved it....
> 
> Atul
> 
> 


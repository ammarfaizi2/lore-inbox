Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTENUDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTENUDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:03:03 -0400
Received: from port-212-202-172-137.reverse.qdsl-home.de ([212.202.172.137]:10904
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id S262610AbTENUC7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:02:59 -0400
Date: Wed, 14 May 2003 22:18:58 +0200 (CEST)
Message-Id: <20030514.221858.846957347.rene.rebe@gmx.net>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC error
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <16066.15561.296849.757291@gargle.gargle.HOWL>
References: <20030513.213112.184808431.rene.rebe@gmx.net>
	<16066.15561.296849.757291@gargle.gargle.HOWL>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: -26.7 (--------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19G2iQ-0002bq-U8*B5tMenZOK6.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On: Wed, 14 May 2003 14:55:37 +0200,
    mikpe@csd.uu.se wrote:

>  > Those errors only seem to happen during high disk-io (SCSI or IDE).
>  > What specific meaning do those errors have? Are they dangerous?
> 
> They are defined in Intel's IA32 manual set, volume 3,
> "System Programming Guide", downloadable from developer.intel.com.
> 
> These errors mean that APIC bus messages are lost or have checksum errors.
> You don't say which kernel you're using or which chipset, but chances are
> your mobo's APIC bus is noisy.
> 
>  > Each CPU survives hours in memtest86 ... And with maxcpus=1 it also
>  > does not seem to happen ... The BIOS is latest.
> 
> You can try booting with "noapic", that should let you keep using SMP
> while avoiding your possibly buggy APIC bus.

Thanks for the anwer I googled for this before the mail but only found
much noise ... I'll triy noapic (I thought this would disable SMP,
too), but I already had to notice that with maxcpus=1 I also get some
few APIC errors.

Is there drawback in using noapic in SMP mode?

Sincerely,
  René Rebe

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://www.rocklinux.org http://www.rocklinux.org/people/rene       
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene


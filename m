Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130499AbRBILVg>; Fri, 9 Feb 2001 06:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130479AbRBILVQ>; Fri, 9 Feb 2001 06:21:16 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:29060 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S130411AbRBILVM>; Fri, 9 Feb 2001 06:21:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10102081055350.9940-100000@clueserver.org> 
In-Reply-To: <Pine.LNX.4.10.10102081055350.9940-100000@clueserver.org> 
To: Alan Olsen <alan@clueserver.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Alex Deucher <adeucher@UU.NET>,
        linux-kernel@vger.kernel.org, jhartmann@valinux.com
Subject: Re: [OT] Re: 2.4.x, drm, g400 and pci_set_master 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 09 Feb 2001 11:19:39 +0000
Message-ID: <4881.981717579@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@clueserver.org said:
>  Both drivers want Matrox's HALlib. (Which is x86 binary only.) Matrox
> will not release the info on that interface to the chipset.  (Using
> the standard corporate excuse whenever they don't want to do something
> "Intelectual Property concerns".)

> Good luck on getting them to make an Alpha version of the library or
> get them to release the underlying library interface specs. 

I submitted a patch to XFree86 on Tuesday which drives the primary head of
G450. It's a cleaned up version of Matrox's own code, and it works on Alpha
for me. Dual head will come later - we have the example code in matroxfb to
work from. All the binary-only HALlib does is mode setup - all the
acceleration is done in the open source code anyway, even when the HALlib 
is present.

 ftp://ftp.uk.linux.org/pub/people/dwmw2/X/mga-G450-patch

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSGPH7E>; Tue, 16 Jul 2002 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317779AbSGPH7D>; Tue, 16 Jul 2002 03:59:03 -0400
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:13477 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S317778AbSGPH7C>; Tue, 16 Jul 2002 03:59:02 -0400
Date: Tue, 16 Jul 2002 04:07:22 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac5 -- Build error in mpparse.c (possible fix)
Message-ID: <20020716080722.GA9375@lnuxlab.ath.cx>
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com> <1026792066.1417.19.camel@localhost.localdomain> <20020716075437.GA9226@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716075437.GA9226@lnuxlab.ath.cx>
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind, this is broken.  pci-pc.c fails to compile.

On Tue, Jul 16, 2002 at 03:54:37AM -0400, khromy wrote:
> --- include/asm-i386/smp.h.old	Tue Jul 16 03:21:52 2002
> +++ include/asm-i386/smp.h	Tue Jul 16 03:39:00 2002
> @@ -34,11 +34,6 @@
>  #define		INT_DEST_ADDR_MODE		1     /* logical delivery */
>  # endif
>  #else
> -#define		clustered_apic_mode		(0)
> -#define		clustered_apic_logical		(0)
> -#define		clustered_apic_physical		(0)
> -#define		apic_broadcast_id		(APIC_BROADCAST_ID_APIC)
> -#define		esr_disable			(0)
>  #define		INT_DELIVERY_MODE		1     /* logical delivery */
>  #define		TARGET_CPUS			0x01
>  #define		INT_DEST_ADDR_MODE		1     /* logical delivery */
> 

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313010AbSC0N32>; Wed, 27 Mar 2002 08:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313011AbSC0N3S>; Wed, 27 Mar 2002 08:29:18 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:52127 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313010AbSC0N3E>; Wed, 27 Mar 2002 08:29:04 -0500
Date: Wed, 27 Mar 2002 14:28:37 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <Pine.LNX.4.44.0203270803150.22597-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.GSO.3.96.1020327142715.8602C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Zwane Mwaikambo wrote:

>  #define FIRST_DEVICE_VECTOR	0x31
> +#define THERMAL_APIC_VECTOR	0x32	/* Thermal monitor local vector */
>  #define FIRST_SYSTEM_VECTOR	0xef

 You certainly want to select a different vector.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


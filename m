Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbTAVLJy>; Wed, 22 Jan 2003 06:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbTAVLJy>; Wed, 22 Jan 2003 06:09:54 -0500
Received: from [213.86.99.237] ([213.86.99.237]:482 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267424AbTAVLJx>; Wed, 22 Jan 2003 06:09:53 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E18b5kc-0003BB-00@bigred.inka.de> 
References: <E18b5kc-0003BB-00@bigred.inka.de>  <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <1042930522.15782.12.camel@laptop.fenrus.com> <E18ai8O-00032u-00@bigred.inka.de> <1043098758.27074.2.camel@laptop.fenrus.com> 
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Jan 2003 11:18:58 +0000
Message-ID: <10554.1043234338@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


olaf@bigred.inka.de said:
>  Only for stand-alone machines which only ever compile and run one
> kernel. You don't need a data center to violate that, you just need
> the fairly usual three-boxes home network (one of which is mainly a
> router/firewall which has no development environment if only for
> security reasons, or because it's a scavenged '486). 

Er, if it has no development environment, why are you bitching about the 
fact that it's not possible to compile kernel modules on it?

The box which holds your firewall's kernel source can be used to compile 
extra out-of-tree modules. The directory /lib/modules/`uname -r`/build, 
while a reasonable _default_ for out-of-tree modules to use, should 
generally be overridable with a directory specified by yourself.

--
dwmw2



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282112AbRLDAf3>; Mon, 3 Dec 2001 19:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280790AbRLDAcl>; Mon, 3 Dec 2001 19:32:41 -0500
Received: from t2.redhat.com ([199.183.24.243]:62452 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281831AbRLDAcQ>; Mon, 3 Dec 2001 19:32:16 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011202230331.E30DA332@localhost.localdomain> 
In-Reply-To: <20011202230331.E30DA332@localhost.localdomain> 
To: WRohdewald@dplanet.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flash ASUS Bios without Floppy? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 04 Dec 2001 00:32:13 +0000
Message-ID: <4608.1007425933@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



WRohdewald@dplanet.ch said:
>  how can I update my Bios (Asus A7V266) if I don't have a floppy drive
> for using the Asus DOS utility?

> Is there any Linux utililty that can do this? 

There are flash chip 'map' drivers which know how to enable WE lines, Vpp 
etc for various northbridges. Only the L440GX one is in the kernel so far. 
For the rest, ask on the LinuxBIOS list <linuxbios@lanl.gov>.

Unless you fancy desoldering your flash chips to replace them when, this is
firmly in the "don't try this at home, kids" category, though :)

--
dwmw2



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWACRJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWACRJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 12:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWACRJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 12:09:38 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:45454 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932437AbWACRJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 12:09:37 -0500
Date: Tue, 03 Jan 2006 11:09:38 -0600
From: Wes Newell <w.newell@verizon.net>
Subject: Re: PATCH: Small fixes backported to old IDE SiS driver
In-reply-to: <1136301581.22598.5.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org
Message-id: <43BAAFD2.7020702@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <1136301581.22598.5.camel@localhost.localdomain>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Some quick backport bits from the libata PATA work to fix things found
>in the sis driver. The piix driver needs some fixes too but those are
>way to large and need someone working on old IDE with time to do them.
>
>This patch fixes the case where random bits get loaded into SIS timing
>registers according to the description of the correct behaviour from
>Vojtech Pavlik. It also adds the SiS5517 ATA16 chipset which is not
>currently supported by the driver. Thanks to Conrad Harriss for loaning
>me the machine with the 5517 chipset.
>
>Alan
>  
>
Did you guys ever get pata working for the real SIS180 chipset? And I 
don't mean the one that's reported as one in the 964 chipset, but a real 
SIS180 like is on the Jetway S755MAX that has 2 serial and 1 pata channels.

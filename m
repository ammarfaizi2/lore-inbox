Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135493AbRAGWlW>; Sun, 7 Jan 2001 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135699AbRAGWlD>; Sun, 7 Jan 2001 17:41:03 -0500
Received: from mailc.telia.com ([194.22.190.4]:31475 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S135493AbRAGWky>;
	Sun, 7 Jan 2001 17:40:54 -0500
Message-Id: <200101072240.XAA02615@zaphod.halden.lillfab.se>
Date: Sun, 7 Jan 2001 23:40:19 +0100 (CET)
From: 5116@telia.com
Reply-To: 5116@telia.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
To: linux-kernel@vger.kernel.org
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E14FKDI-00033e-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Jan, Alan Cox wrote:
>> Um, what about people running their box as just a VLAN router/firewall?
>> That seems to be one of the principle uses so far.  Actually, in that case
>> both VLAN and IP traffic would come through, so it would be a tie if VLAN
>> came first, but non-vlan traffic would suffer worse.
> 
> Why would someone filter between vlans when any node on each vlan can happily
> ignore the vlan partitioning
> 
You might be connected to a vlan capable switch which will only feed the
`right' vlan to a certain port... In this case an one-armed firewall
might make sense.

/Daniel
-- 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

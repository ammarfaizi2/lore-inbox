Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135443AbRAGQoz>; Sun, 7 Jan 2001 11:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135382AbRAGQop>; Sun, 7 Jan 2001 11:44:45 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:49169 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S135483AbRAGQo1>; Sun, 7 Jan 2001 11:44:27 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
Date: 7 Jan 2001 16:44:37 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <93a6dl$6oj$1@enterprise.cistron.net>
In-Reply-To: <3A580B31.7998C783@candelatech.com> <E14FGD4-0002f7-00@the-village.bc.nu>
X-Trace: enterprise.cistron.net 978885877 6931 195.64.65.67 (7 Jan 2001 16:44:37 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14FGD4-0002f7-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>At this point you have to ask 'why is vlan4001 an interface'. Would it not
>be cleaner to add the vlan id to the entries in the list of addresses per
>interface ?

Not all the world is IP - what if you want to bridge between 
an ATM ELAN (LANE) and a VLAN? Note that different ATM ELANs also
show up as seperate interfaces.

Mike.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

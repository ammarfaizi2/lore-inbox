Return-Path: <linux-kernel-owner+w=401wt.eu-S1161243AbWLPRJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWLPRJa (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWLPRJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:09:29 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:34990 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161237AbWLPRJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:09:27 -0500
Message-ID: <4584282C.5060803@pobox.com>
Date: Sat, 16 Dec 2006 12:09:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evan Harris <eharris@puremagic.com>
CC: Milan Kupcevic <milan@physics.harvard.edu>,
       Fabian Knittel <fabian.knittel@avona.com>, linux-scsi@vger.kernel.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Stan Seibert <volsung@mailsnare.net>, linux-ide@vger.kernel.org,
       Christiaan den Besten <chris@scorpion.nl>,
       Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4,
 SATA 300 TX4
References: <43FFAE3D.7010002@physics.harvard.edu> <44000036.7070403@eyal.emu.id.au> <011f01c639f9$8dc86bc0$3d64880a@speedy> <442DB29D.1010102@avona.com> <447CB9B4.50700@physics.harvard.edu> <Pine.LNX.4.62.0610021700350.10249@kinison.puremagic.com>
In-Reply-To: <Pine.LNX.4.62.0610021700350.10249@kinison.puremagic.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evan Harris wrote:
> 
> I have a card that mirrors this one from your list:
> 
> Retail name: SATA300 TX4
> Chip label: PDC40718-GP  SATAII300
> Vendor-Device number: 105a:3d17 (rev 02)
> 
> Through testing, I've found linux 2.6.16 and 2.6.17 find the ports in 
> this order (the list is ordered by linux detection):
> 
> 1. silkscreen port 3
> 2. silkscreen port 2
> 3. silkscreen port 4
> 4. silkscreen port 1
>> NOTE: the patch I have submitted ( 
>> http://marc.theaimsgroup.com/?l=linux-ide&m=114082978311290&w=2 ) is a 
>> solution that doesn't know about the older Promise SATA controllers, 
>> which are not affected with the "new wiring" problem, so the older 
>> controllers will appear screwed if you use it.
>>
>> Hopefully we will collect enough info about all the SATA Promise 
>> controllers to distinguish the new and the old wiring controllers, 
>> then produce a new patch that will be a correct solution to the "new 
>> wiring" problem.

Mikael Pettersson has been doing some excellent work recently on 
sata_promise.  If enough data has been collected on this sata_promise 
port enumeration problem, maybe the data could be collated and proposed 
via Mikael as a patch?

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWHIM3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWHIM3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWHIM3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:29:05 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:28848 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750709AbWHIM3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:29:03 -0400
Date: Wed, 9 Aug 2006 13:53:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hans Reiser <reiser@namesys.com>
cc: Edward Shishkin <edward@namesys.com>,
       Matthias Andree <matthias.andree@gmx.de>, ric@emc.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
In-Reply-To: <44D99F96.4090804@namesys.com>
Message-ID: <Pine.LNX.4.61.0608091352440.23404@yvahk01.tjqt.qr>
References: <200607312314.37863.bernd-schubert@gmx.de>
 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>
 <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com>
 <44CF3DE0.3010501@namesys.com> <20060803140344.GC7431@merlin.emma.line.org>
 <44D219F9.9080404@namesys.com> <44D231DF.1080804@namesys.com>
 <44D37E1B.1040109@namesys.com> <44D3ECB5.1060106@namesys.com>
 <44D66ADD.6020007@namesys.com> <44D99F96.4090804@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yes, it looks like a business of node plugin, but AFAIK, you
>> objected against such checks:
>
>Did I really?  Well, I think that allowing users to choose whether to
>checksum or not is a reasonable thing to allow them.  I personally would
>skip the checksum on my computer, but others....
>
>It could be a useful mkfs option....

It should preferably a runtime tunable variable, at best even
per-superblock and (overriding the sb setting), per-file.


Jan Engelhardt
-- 

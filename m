Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWHCXWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWHCXWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWHCXWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:22:08 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:39888 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751350AbWHCXWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:22:07 -0400
Message-ID: <44D285DF.7060905@elegant-software.com>
Date: Thu, 03 Aug 2006 19:25:19 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
Cc: David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Checksumming blocks? [was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion]
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF84F0.8080303@slaphack.com> <1154452770.15540.65.camel@localhost.localdomain> <44CF9217.6040609@slaphack.com> <20060803135811.GA7431@merlin.emma.line.org>
In-Reply-To: <20060803135811.GA7431@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the software (filesystem like ZFS or database like Berkeley DB)  
finds a mismatch for a checksum on a block read, then what?

Is there a recovery mechanism, or do you just be happy you know there is 
a problem (and go to backup)?

Thx

Matthias Andree wrote:

>Berkeley DB can, since version 4.1 (IIRC), write checksums (newer
>versions document this as SHA1) on its database pages, to detect
>corruptions and writes that were supposed to be atomic but failed
>(because you cannot write 4K or 16K atomically on a disk drive).
>


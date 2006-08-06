Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWHFWTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWHFWTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWHFWTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:19:23 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:27015 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S1750747AbWHFWTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:19:22 -0400
Message-ID: <44D66ADD.6020007@namesys.com>
Date: Mon, 07 Aug 2006 02:19:09 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Matthias Andree <matthias.andree@gmx.de>, ric@emc.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com> <44CF3DE0.3010501@namesys.com> <20060803140344.GC7431@merlin.emma.line.org> <44D219F9.9080404@namesys.com> <44D231DF.1080804@namesys.com> <44D37E1B.1040109@namesys.com> <44D3ECB5.1060106@namesys.com>
In-Reply-To: <44D3ECB5.1060106@namesys.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Edward Shishkin wrote:
> 
> 
>>>
>>>How about we switch to ecc, which would help with bit rot not sector
>>>loss?
>>
>>
>>Interesting aspect.
>>
>>Yes, we can implement ECC as a special crypto transform that inflates
>>data. As I mentioned earlier, it is possible via translation of key
>>offsets with scale factor > 1.
>>
>>Of course, it is better then nothing, but anyway meta-data remains
>>ecc-unprotected, and, hence, robustness is not increased..
>>
>>Edward.
> 
> 
> Would you prefer to do it as a node layout plugin instead, so as to get
> the metadata?
> 

Yes, it looks like a business of node plugin, but AFAIK, you
objected against such checks: currently only bitmap nodes have
a protection (checksum); supporting ecc-signatures is more
space/cpu expensive.

Edward.

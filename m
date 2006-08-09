Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030611AbWHIJk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030611AbWHIJk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWHIJk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:40:56 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:13754 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1030611AbWHIJk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:40:56 -0400
Message-ID: <44D99F96.4090804@namesys.com>
Date: Wed, 09 Aug 2006 02:40:54 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Shishkin <edward@namesys.com>
CC: Matthias Andree <matthias.andree@gmx.de>, ric@emc.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF9BAD.5020003@emc.com> <44CF3DE0.3010501@namesys.com> <20060803140344.GC7431@merlin.emma.line.org> <44D219F9.9080404@namesys.com> <44D231DF.1080804@namesys.com> <44D37E1B.1040109@namesys.com> <44D3ECB5.1060106@namesys.com> <44D66ADD.6020007@namesys.com>
In-Reply-To: <44D66ADD.6020007@namesys.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Shishkin wrote:

> Hans Reiser wrote:
>
>> Edward Shishkin wrote:
>>
>>
>>>>
>>>> How about we switch to ecc, which would help with bit rot not sector
>>>> loss?
>>>
>>>
>>>
>>> Interesting aspect.
>>>
>>> Yes, we can implement ECC as a special crypto transform that inflates
>>> data. As I mentioned earlier, it is possible via translation of key
>>> offsets with scale factor > 1.
>>>
>>> Of course, it is better then nothing, but anyway meta-data remains
>>> ecc-unprotected, and, hence, robustness is not increased..
>>>
>>> Edward.
>>
>>
>>
>> Would you prefer to do it as a node layout plugin instead, so as to get
>> the metadata?
>>
>
> Yes, it looks like a business of node plugin, but AFAIK, you
> objected against such checks:

Did I really?  Well, I think that allowing users to choose whether to
checksum or not is a reasonable thing to allow them.  I personally would
skip the checksum on my computer, but others....

It could be a useful mkfs option....

> currently only bitmap nodes have
> a protection (checksum); supporting ecc-signatures is more
> space/cpu expensive.
>
> Edward.
>
>


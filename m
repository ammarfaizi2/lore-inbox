Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271658AbRH0HlV>; Mon, 27 Aug 2001 03:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271669AbRH0HlP>; Mon, 27 Aug 2001 03:41:15 -0400
Received: from tangens.hometree.net ([212.34.181.34]:51939 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S271658AbRH0HkD>; Mon, 27 Aug 2001 03:40:03 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Poor Performance for ethernet bonding
Date: Mon, 27 Aug 2001 07:40:19 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9mcth3$cs2$1@forge.intermeta.de>
In-Reply-To: <3B865882.24D57941@biochem.mpg.de.suse.lists.linux.kernel> <oupg0ahmv2a.fsf@pigdrop.muc.suse.de> <3B867096.3A1D7DE@candelatech.com> <20010824172256.A2531@gruyere.muc.suse.de> <3B86769D.17A979D7@candelatech.com> <20010824180400.B2848@gruyere.muc.suse.de>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 998898019 17133 212.34.181.4 (27 Aug 2001 07:40:19 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 27 Aug 2001 07:40:19 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>On Fri, Aug 24, 2001 at 08:45:33AM -0700, Ben Greear wrote:
>> On the surface, multi-path routing sounds complicated to me, while
>> layer-2 bonding seems relatively trivial to set up/administer.  Since we do
>> support bonding, if it's a simple fix to make it better, we
>> might as well do that, eh?

>multipath routing is really not complicated; I don't know why it "sounds"
>complicated to you. Of course you could always add new features to the kernel
>because the existing ones which do the same thing in a better way
>"sound complicated" to someone; I doubt it is a good use of developer time 
>however. 

But it is still the wrong layer.

Ethernet Bonding ist "below" IP. Very handy if you want to run
something "not ip".

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

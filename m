Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWIDNYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWIDNYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWIDNYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:24:00 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:18166 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964924AbWIDNX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:23:59 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: Raid 0 Swap?
To: Michael Tokarev <mjt@tls.msk.ru>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 04 Sep 2006 15:21:08 +0200
References: <6R8WW-70v-7@gated-at.bofh.it> <6RgKP-1OA-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GKEOG-0000s1-Ru@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev <mjt@tls.msk.ru> wrote:

> Marc Perkel wrote:
>> If I have two drives and I want swap to be fast if I allocate swap spam
>> on both drives does it break up the load between them? Or would it run
>> faster if I did a Raid 0 swap?

Swap has priorities, and it will do something like striping if two swap spaces
have the same priority.

[...]
> Ie, your swap space must be reliable.  At least not worse than your memory.

It's mostly enough if it's as reliable as the system disk.

> And with striping, you've much more chances of disk failure...

It won't increase because of using striping, but because of the amount
of disks used.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html

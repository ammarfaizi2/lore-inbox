Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbTF2QM7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 12:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbTF2QM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 12:12:59 -0400
Received: from indyio.rz.uni-saarland.de ([134.96.7.3]:25638 "EHLO
	indyio.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S265694AbTF2QM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 12:12:58 -0400
Message-ID: <3EFF1349.6020802@hipac.org>
Date: Sun, 29 Jun 2003 18:26:49 +0200
From: Michael Bellion and Thomas Heinz <nf@hipac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pekka Savola <pekkas@netcore.fi>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
References: <Pine.LNX.4.44.0306290924310.28882-100000@netcore.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka

You wrote:
>>We are going to test the stuff tomorrow on an i386 and tell you
>>the results afterwards.

Well, nf-hipac works fine together with the ebtables patch for 2.4.21
on an i386 machine. We expect it to work with other patches too.

>>In principle, nf-hipac should work properly whith the bridge patch.
>>We expect it to work just like iptables apart from the fact that
>>you cannot match on bridge ports.

Well, this statement holds for the native nf-hipac in/out interface
match but of course you can match on bridge ports with nf-hipac
using the iptables physdev match. So everything should be fine :)

> One obvious thing that's missing in your performance and Roberto's figures 
> is what *exactly* are the non-matching rules.  Ie. do they only match IP 
> address, a TCP port, or what? (TCP port matching is about a degree of 
> complexity more expensive with iptables, I recall.)

[answered in private e-mail]


Regards,

+-----------------------+----------------------+
|   Michael Bellion     |     Thomas Heinz     |
| <mbellion@hipac.org>  |  <creatix@hipac.org> |
+-----------------------+----------------------+


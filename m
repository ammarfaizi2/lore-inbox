Return-Path: <linux-kernel-owner+w=401wt.eu-S1755224AbXAAPYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbXAAPYw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 10:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755225AbXAAPYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 10:24:52 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:50225 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224AbXAAPYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 10:24:51 -0500
Date: Mon, 1 Jan 2007 16:23:53 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Folkert van Heusden <folkert@vanheusden.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Mailing List <netfilter@lists.netfilter.org>
Subject: Re: chaostables-0.2 & 2.6.19.1
In-Reply-To: <20070101151505.GE7816@vanheusden.com>
Message-ID: <Pine.LNX.4.61.0701011622040.21491@yvahk01.tjqt.qr>
References: <20070101143812.GA7816@vanheusden.com>
 <Pine.LNX.4.61.0701011541130.21491@yvahk01.tjqt.qr> <20070101151505.GE7816@vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 1 2007 16:15, Folkert van Heusden wrote:

>> >I'm trying to compile chaostables v0.2 on a system with kernel 2.6.19.1
>> >and c-compiler 3.4.6:
>> >/usr/src/chaostables-0.2/kernel/xt_CHAOS.c: In function `xt_chaos_target':
>> >/usr/src/chaostables-0.2/kernel/xt_CHAOS.c:53: error: too many arguments to function
>>
>> Yes I found this one this morning. The issue is simple: function 
>> signatures have changed in 2.6.19 and 2.6.20 which I did not all catch 
>> yet. chaostables compiles fine with 2.6.18 however. I shall have it 
>> workarounded in the next release. Thanks for noticing! (cc to 
>> linuxkernel and netfilter before more people run into the same problem)
>
>Not wanting to put you under pressure but when is that version expected?

Just about now, I just made a snapshot.
http://jengelh.hopto.org/f/chaostables/chaostables-0.3.tar.bz2
(The new (note above: snapshot) SREJECT is not complete. Just fixed the 2.6.19
and 2.6.20 compiles.)


	-`J'
-- 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTIIPOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 11:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264214AbTIIPOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 11:14:12 -0400
Received: from postal.usc.edu ([128.125.253.6]:60664 "EHLO postal.usc.edu")
	by vger.kernel.org with ESMTP id S264203AbTIIPOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 11:14:08 -0400
Date: Tue, 09 Sep 2003 08:13:39 -0700
From: Phil Dibowitz <phil@ipom.com>
Subject: Re: Linux IDE bug in 2.4.21 and 2.4.22 ?
In-reply-to: <200309091701.48993.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Message-id: <3F5DEE23.6020106@ipom.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827
 Debian/1.4-3
References: <20030908225107.GE17108@earthlink.net>
 <200309091448.36231.bzolnier@elka.pw.edu.pl> <3F5DE49E.50500@ipom.com>
 <200309091701.48993.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>>But, what about the case when I built in the generic driver, but made
>>the CMD649 driver a module, and loaded it after boot. That shouldn't
>>have *changed* what ide0 and ide1 are, right? I had ide0 and ide1
>>assigned, did a modprobe, and CMD649 changed what ide0 adn ide1 where,
>>and then forgot about the previous ones.. like all of a sudden it told
>>the generic driver "no, no, you were wrong, there's no VIA chipset here,
>>go back to sleep."
> 
> 
> Hmm. please send me dmesg.
> 

I'm happy to. Assumably you want both a Dmesg of my new working kernel, 
and a dmesg of above described kernel? Note that the dmesg from the 
later kernel be before loading the CMD64X modules, because when I do 
that, I loose my hard drive. Therefore it'll look mostly like my working 
one, except with no ide2 and ide3.

I've gone ahead and posted the current working dmesg here:
http://www.phildev.net/dmesg-working

I'll have to do the non-working kernel when I get back from work. I'll 
drop a line when I get that posted.

Thanks,
-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263951AbTCWWFf>; Sun, 23 Mar 2003 17:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263953AbTCWWFe>; Sun, 23 Mar 2003 17:05:34 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:1922 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S263951AbTCWWFd>;
	Sun, 23 Mar 2003 17:05:33 -0500
Message-ID: <3E7E3248.7070307@portrix.net>
Date: Sun, 23 Mar 2003 23:16:40 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Brodowski <linux@brodo.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless looping
 / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
References: <20030322140337.GA1193@brodo.de> <1048350905.9219.1.camel@irongate.swansea.linux.org.uk> <20030322162502.GA870@brodo.de> <1048354921.9221.17.camel@irongate.swansea.linux.org.uk> <20030323010338.GA886@brodo.de> <1048434472.10729.28.camel@irongate.swansea.linux.org.uk> <20030323145915.GA865@brodo.de> <1048444868.10729.54.camel@irongate.swansea.linux.org.uk> <20030323181532.GA6819@brodo.de> <20030323182554.GA1270@brodo.de>
In-Reply-To: <20030323182554.GA1270@brodo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Sun, Mar 23, 2003 at 07:15:33PM +0100, Dominik Brodowski wrote:
>>Just got it to boot :) -- the while(!list_empty...) { list_entry ... looks
>>suspicious. Might be better to use list_for_each_safe() which is designed
>>exactly for this purpouse. I'm currently recompiling
>>2.5.65-bk-current-as-of-yesterday with the attached patch. Let's see whether
>>it works with this kernel, too...
> 
> 
> Yes, it also works with 2.5.65-bkX.
> 

Yes, my system also boots again :)

Thanks,

Jan


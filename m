Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262603AbUJ2W54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbUJ2W54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbUJ2WzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:55:14 -0400
Received: from hermes.domdv.de ([193.102.202.1]:42511 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S263572AbUJ2WyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:54:10 -0400
Message-ID: <4182CA09.8030002@domdv.de>
Date: Sat, 30 Oct 2004 00:54:01 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kenneth_Aafl=F8y?= <lists@kenneth.aafloy.net>
CC: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       typo@shaw.ca, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paulo Marques <pmarques@grupopie.com>
Subject: Re: Linuxant/Conexant HSF/HCF Modem Drivers Unlocked
References: <1099032721.23148.5.camel@localhost> <20041029200011.GA18508@redhat.com> <4182AA06.5030901@domdv.de> <200410300046.03148.lists@kenneth.aafloy.net>
In-Reply-To: <200410300046.03148.lists@kenneth.aafloy.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Aafløy wrote:
> On Friday 29 October 2004 22:37, you wrote:
> 
>>Dave Jones wrote:
>>
>>>On Fri, Oct 29, 2004 at 02:50:42PM +0100, Alan Cox wrote:
>>> > Oh its almost certainly a criminal offence in the USA - the DMCA for
>>> > example. The \0 stupidity checker needs to go into the kernel.
>>>
>>>Copy protection arms-races are always fun. If we did this, no doubt
>>>some enterprising individual would find that some other value
>>>also has the same effect.  You need to throw out anything else
>>>thats non alphanumeric too.  (plus '/' for 'Dual BSD/GPL' and friends)
>>
>>How about 'GPL\rMy real license'? Which means: yes, you're absolutely
>>right.
> 
> 
> Not that I care, but wouldn't a simple _licence_length field solve this?

I don't think that a length filed is sufficient. The above example would 
print out on a standard terminal as 'My real license'. To prevent 
license string abuse a quite short (less than 80 characters) length 
limit and restriction to simple printable (i.e. 0x20-0x7e ASCII) 
characters is required.
I would prefer that modules not obeying these restrictions can't be 
loaded into the kernel.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

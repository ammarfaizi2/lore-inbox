Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTLQSRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTLQSRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:17:14 -0500
Received: from fmr99.intel.com ([192.55.52.32]:34272 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S264443AbTLQSRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:17:13 -0500
Message-ID: <3FE09D22.2080206@intel.com>
Date: Wed, 17 Dec 2003 20:14:58 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Dan Hopper <ku4nf@austin.rr.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com> <Pine.LNX.4.58.0312162240040.8541@home.osdl.org> <Pine.GSO.4.58.0312171105200.24864@waterleaf.sonytel.be> <Pine.LNX.4.58.0312170753400.8541@home.osdl.org> <20031217174427.GA31730@obiwan.dummynet>
In-Reply-To: <20031217174427.GA31730@obiwan.dummynet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

all your statements are correct. Indeed, all PCI devices works without 
extra knowledge about PCI-E.
 I have nothing to add.
Vladimir.

Dan Hopper wrote:

>Linus Torvalds <torvalds@osdl.org> remarked:
>  
>
>>On Wed, 17 Dec 2003, Geert Uytterhoeven wrote:
>>    
>>
>>>For the record: PCI Express is _not_ PCI-X.
>>>      
>>>
>>Ok, but "PCI Express" is too damn long to write, so we'll have to have 
>>_some_ sane name for it without typing for half an hour.
>>    
>>
>
>FWIW, "PCI-E" is in common use in these parts.
>
>Also, wrt the config space backward compatibility issue, it is my
>understanding that the PCI-E root complex and PCI-E devices can be
>enumerated and used successfully with no software changes, within
>the constraints of PCI.  The BIOS or OS should be able to enumerate
>devices, probe BARs and assign resources, perform basic error
>handling, etc. without any PCI-E-specific changes. 
>
>The hardware is required to be able to initialize PCI-E links, set
>things up to sane states, and so forth without software assistance
>in order to make this magic happen.  It would be interesting to hear
>from Vladimir as to whether or not this is happening with his PCI-E
>test system.
>
>Having said all that, it's obviously preferable to end up with
>native OS and BIOS support for the PCI-E extended configuration
>space, extra error reporting mechanisms, etc.  Native PCI-E devices
>hanging off the bus somewhere might not work (or, at least, work
>well) with an OS that doesn't grok the PCI-E extensions.  
>
>Dan
>  
>


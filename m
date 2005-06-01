Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVFAODv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFAODv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVFAODv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:03:51 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:64229 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261381AbVFAODq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:03:46 -0400
Message-ID: <429DC041.6070001@de.ibm.com>
Date: Wed, 01 Jun 2005 16:03:45 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Arnd Bergmann <arnd@arndb.de>, coywolf@lovecn.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 0/5] add execute in place support
References: <428216DF.8070205@de.ibm.com> <2cd57c9005060103122b2bae36@mail.gmail.com> <200506011406.04191.arnd@arndb.de> <20050601133938.GB29116@wohnheim.fh-wedel.de>
In-Reply-To: <20050601133938.GB29116@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Wed, 1 June 2005 14:06:03 +0200, Arnd Bergmann wrote:
>  
>
>>On Middeweken 01 Juni 2005 12:12, Coywolf Qi Hunt wrote:
>>    
>>
>>>>As I'd like to aim for integration into -mm and vanilla later on,
>>>>I'd like to encourage everyone to give it a read and provide
>>>>feedback. All patches apply against git-head as of today.
>>>>        
>>>>
>>>I feel the name "execute in place" misleading. This is not the real
>>>XIP, IMHO. Invent another term or be tolerant?
>>>      
>>>
>>If this is not real execute in place, then what is? The term seems to
>>describe the patch rather well and we don't have this ability for Linux
>>applications anywhere else, at least not in official kernels.
>>    
>>
>
>We can execute the kernel in place, thanks to Nicolas Pitre.  For
>userspace I have seen to preparation patches, but nothing serious.
>  
>
Given that execute in place describes the ability to run code at
the very same location where it is permanently stored, and that
this is exactly what the patch enables, I think the wording is
correct.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbUBOJ7L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 04:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUBOJ7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 04:59:11 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:5282 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264437AbUBOJ7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 04:59:08 -0500
Message-ID: <402F42DE.5090308@t-online.de>
Date: Sun, 15 Feb 2004 10:58:54 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040129
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@lovecn.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <402A887D.7030408@t-online.de> <402EDBA8.4070102@lovecn.org>
In-Reply-To: <402EDBA8.4070102@lovecn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: TWiJRZZ6weYXLWum2jPF98I-2d1vcdjtzr0K0WifmIDUTW-UTBpbw9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> Harald Dunkel wrote:
> 
>>
>> What would be the correct way to get the filename of a
>> loaded module? The basename would be sufficient.
>>
>>
> The symbole names used in source code, like function names tend to use 
> "_", while the file names use "-" IMHO.
> 

Naturally the symbols in the code use '_', cause for C '-'
is not allowed within symbol names.

I am interested in the module file names. 'cat /proc/modules'
should return the correct module names, but for some modules
(like uhci_hcd vs uhci-hcd.ko) '_' and '-' are messed up.


Regards

Harri

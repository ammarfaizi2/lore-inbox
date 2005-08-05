Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVHEGcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVHEGcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVHEGcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:32:00 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:2028 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262878AbVHEGbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:31:48 -0400
Message-ID: <42F307C4.9010503@davyandbeth.com>
Date: Fri, 05 Aug 2005 01:31:32 -0500
From: Davy Durham <pubaddr2@davyandbeth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc question
References: <42F30252.3080105@davyandbeth.com> <Pine.LNX.4.61.0508050823530.20623@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0508050823530.20623@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>I have a zombie process which has apparently died for some unknown reason.. I
>>know it was terminated by a signal (found that from the 9th field (sheduler
>>flags) in /proc/pid/stat)
>>    
>>
>
>Start the process under the observation of strace.
>
>  
>
>>However, I'm trying to figure out what signal killed it.
>>    
>>
>
>
>Jan Engelhardt
>  
>
Wish I could.. but it's already happened (to a lot of processes for the 
same reason)

It's an intermittant problem and can't really reproduce it at will.

I've redeployed the binary now so I can hopefully attach to it with gdb 
to figure out some things next time it does happen.

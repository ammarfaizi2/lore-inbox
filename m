Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUHQAmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUHQAmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 20:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUHQAmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 20:42:05 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:21732 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S266477AbUHQAmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 20:42:01 -0400
Message-ID: <41215459.5070401@redhat.com>
Date: Mon, 16 Aug 2004 20:42:01 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike_Phillips@URSCorp.com
CC: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [Patch} to fix oops in olympic token ring driver on media disconnect
References: <OF11E315D2.D4CBAED1-ON85256EF2.0052F29D-85256EF2.0053587E@urscorp.com>
In-Reply-To: <OF11E315D2.D4CBAED1-ON85256EF2.0052F29D-85256EF2.0053587E@urscorp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike_Phillips@URSCorp.com wrote:

>>Well, regardless, Neil's patch is IMO a good first step.
>>    
>>
>
>Neil's patch is to make the annoying regression test failure go away. To 
>be honest I have had *one* user email me that this is a problem and once I 
>gave them the "don't remove the cable on token ring, its not ethernet" 
>talk, they were fine. 
>
>  
>
I'm confused mike, it makes an annoying regression test go away, and it 
fixes the problem of one, now two users, not to mention anyone else who 
didn't report this. Is there something specific you don't like about 
this patch?  If so, please let me know.

>>There is plenty of work in olympic for any motivated person :)
>>    
>>
>
>It works, its used by an ever decreasing number of users - let it have a 
>peaceful and graceful old age. 
>
>Mike
>  
>
I don't think oopsing on a lobe fault is graceful, or peaceful to anyone 
experiencing it.  :)


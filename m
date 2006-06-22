Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWFVVjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWFVVjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWFVVjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:39:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7109 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932656AbWFVVjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:39:15 -0400
Message-ID: <449B0DF7.5000407@zytor.com>
Date: Thu, 22 Jun 2006 14:39:03 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Eduard-Gabriel Munteanu <maxdamage@aladin.ro>
CC: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Is the x86-64 kernel size limit real?
References: <20060622204627.GA47994@dspnet.fr.eu.org> <449B355C.2080805@aladin.ro>
In-Reply-To: <449B355C.2080805@aladin.ro>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard-Gabriel Munteanu wrote:
> *This message was transferred with a trial version of CommuniGate(r) Pro*
> Olivier Galibert wrote:
> 
>>
>> which shows two things:
>> 1- a8f5034540195307362d071a8b387226b410469f should have a x86-64 version
>> 2- the limit looks entirely artificial
>>
>> So, is removing the limit prone to bite me?
>>
>>   OG.
> 
> The build system merely tries to warn you it's not going to fit on a 
> floppy disk. "bzImage" means "Big zImage", not "bz2-compressed Image", 
> so unless you're building a floppy disk, don't use zImage.
> 

He's talking about the bzImage limit, not the zImage limit.  The bzImage limit in x86-64 
is real (in the sense it exists) but incorrect (in the sense that it has the wrong value); 
see my other post.

	-hpa

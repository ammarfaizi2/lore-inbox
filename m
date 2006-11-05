Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbWKEXNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbWKEXNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWKEXNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:13:13 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:56514 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932747AbWKEXNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:13:12 -0500
Message-ID: <454E7008.4020200@vmware.com>
Date: Sun, 05 Nov 2006 15:13:12 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: caglar@pardus.org.tr
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Gerd Hoffmann <kraxel@suse.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: [Opps] Invalid opcode
References: <200611051507.37196.caglar@pardus.org.tr> <200611051917.56971.caglar@pardus.org.tr> <200611051957.45260.ak@suse.de> <200611052151.14861.caglar@pardus.org.tr>
In-Reply-To: <200611052151.14861.caglar@pardus.org.tr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

S.Çağlar Onur wrote:
> Hmm, Novell bugzilla seems has similiar issues, 
> https://bugzilla.novell.com/show_bug.cgi?id=204647 and its duplicated ones 
> gaves same or similiar panic outputs.
>
>   
>> Previously we avoided converting i386 cpu bootup fully to the new state
>> machine because it is very fragile, but it's possible that there
>> is no other choice than to do it properly. Or maybe another kludge
>> is possible.
>>     

Yes, this is some kind of softirq race during init.

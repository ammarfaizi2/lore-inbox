Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVA1QrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVA1QrX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVA1QrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:47:23 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:3202 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261476AbVA1QrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:47:19 -0500
Message-ID: <41FA6C93.2000900@g-house.de>
Date: Fri, 28 Jan 2005 17:47:15 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vojtech Pavlik <vojtech@suse.cz>, Wiktor <victorjan@poczta.onet.pl>
Subject: Re: AT keyboard dead on 2.6
References: <41F11F79.3070509@poczta.onet.pl> <20050128142826.GA12137@ucw.cz>
In-Reply-To: <20050128142826.GA12137@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Fri, Jan 21, 2005 at 04:27:53PM +0100, Wiktor wrote:
> 
>>Hi,
>>
>>my AT keyboard is dead on 2.6 series. Tests on other machines proves 
>>that this is my-hardware-specyfic problem (exacly the same binnary works 
>>on different mainboards with PS/2 keyboard and another AT keyboard). 2.4 
>>series works correctly. On 2.6 kernel seems to not hear what keyboard 
>>wants to tell him (eg. atkbd.reset preforms keyboard reset but reports 
>>error). Were any hadrware-handling changes made since 2.4? If so, how to 
>>undo them and make keyboard alive? I'm grateful for any help.
>  
> Please try i8042.noaux=1. You say you're using a serial mouse in your
> other e-mail, so the system may not have an AUX port yet the kernel
> thinks it does. This may cause the keyboard to stop responding.

fyi, there is a thread going on on linuxppc-dev regarding a similiar 
looking issue: 
http://ozlabs.org/pipermail/linuxppc-dev/2005-January/018321.html
someone suggested booting with atkbd.reset=0, maybe the problems are 
somehow related? what exact kernel version are you using, Wiktor?

Christian.
-- 
BOFH excuse #20:

divide-by-zero error

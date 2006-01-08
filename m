Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161247AbWAHXaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161247AbWAHXaE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 18:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161245AbWAHXaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 18:30:04 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:12978 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1161242AbWAHXaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 18:30:03 -0500
Date: Sun, 8 Jan 2006 15:29:26 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Arjan van de Ven <arjan@infradead.org>
cc: "Kurtis D. Rader" <kdrader@us.ibm.com>, Dave Jones <davej@redhat.com>,
       Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
In-Reply-To: <1136670488.2936.44.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0601081527170.2907@qynat.qvtvafvgr.pbz>
References: <20060104221023.10249eb3.rdunlap@xenotime.net><E1EuPZg-0008Kw-00@calista.inka.de>
 <20060105111105.GK20809@redhat.com><20060107214439.GA13433@us.ibm.com>
 <1136670488.2936.44.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Arjan van de Ven wrote:

> On Sat, 2006-01-07 at 13:44 -0800, Kurtis D. Rader wrote:
>> On Thu, 2006-01-05 06:11:05, Dave Jones wrote:
>>> On Thu, Jan 05, 2006 at 08:30:16AM +0100, Bernd Eckenfels wrote:
>>> > Randy.Dunlap <rdunlap@xenotime.net> wrote:
>>> >> This one delays each printk() during boot by a variable time
>>> >> (from kernel command line), while system_state == SYSTEM_BOOTING.
>>> >
>>> > This sounds a bit like a aprils fool joke, what it is meant to do? You can
>>> > read the messages in the bootlog and use the scrollback keys, no?
>>>
>>> could be handy for those 'I see a few messages that scroll, and the
>>> box instantly reboots' bugs.  Quite rare, but they do happen.
>>
>> Another very common situation is a system which fails to boot due to
>> failures to find the root filesystem. This can happen because of device name
>> slippage, root disk not being found, the proper HBA driver isn't present in
>
> mount by label fixes some of that but not all

there appears to be a limit on how many disks get checked for their label. 
I've got one system where I've got 2xraid cards each with 8 drives on them 
and then another raid card with my boot disk on it.

depending on how I have the two raid cards the boot disk can be anything 
from sdc to sdq, mounting by label works for sdc, but not for sdq.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare


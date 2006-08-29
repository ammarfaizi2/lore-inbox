Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWH2MVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWH2MVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWH2MVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:21:35 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:53848 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750822AbWH2MV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:21:28 -0400
Message-ID: <44F43209.6040603@sw.ru>
Date: Tue, 29 Aug 2006 16:24:41 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Luck, Tony" <tony.luck@intel.com>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>, gregkh@suse.de,
       akpm@osdl.org, dev@openvz.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net, stable@kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com, xemul@openvz.org
Subject: Re: [stable] [PATCH] Linux 2.6.17.11 - fix compilation error on IA64
 (try #3)
References: <617E1C2C70743745A92448908E030B2A72869D@scsmsx411.amr.corp.intel.com> <20060829013137.GA27869@kroah.com>
In-Reply-To: <20060829013137.GA27869@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Aug 28, 2006 at 03:11:31PM -0700, Luck, Tony wrote:
> 
>>>The commit 8833ebaa3f4325820fe3338ccf6fae04f6669254 introduced a change that broke 
>>>IA64 compilation as shown below:
>>
>>What happened to the mainline version of the patch to which this
>>is a fix (local DoS with corrupted ELFs)?  I don't see it in 2.6.18-rc5.
>>Did it get fixed some other way, or is it just queued somewhere?  Or do
>>we have a fix in -stable that isn't in mainline?
> 
> 
> I thought this was a fix for a prior -stable patch that did not affect
> mainline.  Or was this thought wrong?
both patches should be passed to Linus.
Probably it is my fault, since I thought that patches which got into -stable
automatically go into Linus tree.

Thanks,
Kirill


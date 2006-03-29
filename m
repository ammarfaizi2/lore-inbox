Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWC2EOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWC2EOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWC2EOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:14:04 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:30820 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750796AbWC2EOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:14:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=d5ZkG7/iqXXiu2rZiecxXAVgVArMcmh3OQLQL9TtoF5JYLVxiuZ1d30ebXwM8qOBk04OIED4XKvDbUVJgR1aONummQJei0arcXeraVT1znqBMtmb03rlsZ6Xy2SA7lALONYJxLk8vweurbwKRsCtyDtRTiZEN4bj5BNkEnAXGDE=
Message-ID: <442A0980.6060403@gmail.com>
Date: Wed, 29 Mar 2006 13:13:52 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Dan Aloni <da-x@monatomic.org>, linux-kernel@vger.kernel.org
Subject: Re: Status of NCQ in libata
References: <20060326192749.GA3643@localdomain> <20060327072945.GC8186@suse.de>
In-Reply-To: <20060327072945.GC8186@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Mar 26 2006, Dan Aloni wrote:
>> Hello,
>>
>> I'd like to know about the current status of NCQ support in libata,
>> whether anyone is actively working on it, where I should find a 
>> development branch (there's no ncq branch anymore in libata-dev.git
>> it seems) and when an upstream merge should be expected.
> 
> You can give it a spin in the 'ncq' branch in the block layer git repo:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
> 
> Only one real bit needs to get merged in libata for ncq to be submitted,
> and that is Tejun's eh rework. Once that is in, ncq becomes a fairly
> small patch and can probably go straight in.
> 
> AHCI is still the only supported controller, once NCQ is merged I'm sure
> a few others will follow.
> 

Patches going out later today. :) I've just ported the NCQ stuff over it 
and about to test it. As I have the doc and hardware NCQ support for 
sata_sil24 will soon follow.

-- 
tejun

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWHPJwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWHPJwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWHPJwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:52:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:37646 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751079AbWHPJwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:52:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ofHVIz511vhWMoCtfiUYmKX6SglFIpf5xj2ZaeqSgQEIa+xPhv4AywAeT9HtOK/BCTwUaekEQcNRoCItxfPEsd1p1DSph3GbHGmF7ogKZkDhvTrsUy7plpJYKnl3h2khGRpmpZt25a9fqmYyBH/aaKItHpNH+dHgQPcFJdnzHL4=
Message-ID: <44E2EAE0.7080207@gmail.com>
Date: Wed, 16 Aug 2006 11:52:09 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       support@moxa.com.tw
Subject: Re: [PATCH 1/1 -resend] Char: mxser, upgrade to 1.9.1
References: <mxser191resend3_ee43092305ba163fd5d4@wsc.cz> <200608160831.12848.arekm@pld-linux.org> <20060815234512.0d3bc1d7.akpm@osdl.org> <200608161127.32849.arekm@pld-linux.org>
In-Reply-To: <200608161127.32849.arekm@pld-linux.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:
> On Wednesday 16 August 2006 08:45, Andrew Morton wrote:
> 
>>>> Perhaps we could create an mxser-new.c and offer that in config, plan
>>>> to remove mxser.c N months hence?
>>> I can test the updated driver with  MOXA CP-168U series board if it will
>>> compile on 2.6.12.6.
>> Thanks.
>>
>>> Unfortunately I can't change kernel to latest one there.
>>> Will testing on 2.6.12.6 be enough for you?
> [...]
>> Perhaps it'll work if you apply the patch to 2.6.18-rc4 then copy the
>> patched files over to 2.6.12..
> 
> I've copied 2.6.18rc4+1.9.1 update applied to 2.6.12 + applied patch below, started minicom
> and tried to write something... at that moment machine blew up - instantly rebooted.
> Nothing on serial console unfortunately. 

Grrr. Grr. Could you, please, revert 
http://www.fi.muni.cz/~xslaby/sklad/mxreverse/* one-by-one to find out which 
change causes it (it applies on the top of proposed 1.9.1 patch)?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

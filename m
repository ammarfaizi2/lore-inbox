Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUISXow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUISXow (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 19:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUISXow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 19:44:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33772 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264937AbUISXot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 19:44:49 -0400
Message-ID: <414E19DF.4090807@redhat.com>
Date: Sun, 19 Sep 2004 19:44:31 -0400
From: Neil Horman <nhorman@redhat.com>
Reply-To: nhorman@redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>,
       linux-kernel@vger.kernel.org
Subject: Re: Is anyone using vmware 4.5 with 2.6.9-rc2-mm1?
References: <200409191214.47206.norberto+linux-kernel@bensa.ath.cx> <D36064A5-0A5D-11D9-96E1-000D9352858E@linuxmail.org>
In-Reply-To: <D36064A5-0A5D-11D9-96E1-000D9352858E@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

> On Sep 19, 2004, at 17:14, Norberto Bensa wrote:
>
>> Hello list,
>>
>> This is what vmware is saying:
>>
>>     "Could not mmap 139264 bytes of memory from file offset 0 at (nil):
>>     Operation not permitted. Failed to allocate shared memory."
>>
>>
>> Vmware works fine with 2.6.9-rc1-mm5.
>
>
> It's woking fine for me... I'm using VMwareWorkstation-4.5.2-8848 
> running on top of kernel-2.6.9-rc2-mm1-VP-S1 and Fedora Core RawHide 
> with no apparent problems (i.e. dmesg shows no errors) and total 
> functionality.
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Have you accidentally turned down the maximum sized shared memory 
segment on your system, making an allocation of shared memory of that 
size impossible? (assuming the 2.6 kernel has the same tunable that the 
2.4 series had for shared memory).
Neil

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUITLJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUITLJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUITLJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:09:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45718 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266216AbUITLJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:09:04 -0400
Message-ID: <414EBA3A.6010205@redhat.com>
Date: Mon, 20 Sep 2004 07:08:42 -0400
From: Neil Horman <nhorman@redhat.com>
Reply-To: nhorman@redhat.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
CC: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: Is anyone using vmware 4.5 with 2.6.9-rc2-mm1?
References: <200409191214.47206.norberto+linux-kernel@bensa.ath.cx> <D36064A5-0A5D-11D9-96E1-000D9352858E@linuxmail.org> <414E19DF.4090807@redhat.com> <200409192329.26604.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200409192329.26604.norberto+linux-kernel@bensa.ath.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:

>Neil Horman wrote:
>  
>
>>Have you accidentally turned down the maximum sized shared memory
>>segment on your system, making an allocation of shared memory of that
>>size impossible? 
>>    
>>
>
>Hm no, I think not; but how do I find that anyways?
>
>Many thanks in advance,
>Norberto
>  
>
The values in /proc/sys/kernel/ that begin with shm defined the 
boundaries of what you can allocate in term of shared memory.  i'm not 
sure if their meanings have changed at all from the 2.4 kernel series, 
so you might have to do some poking at the code to understand them.
HTH
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


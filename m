Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVEPORY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVEPORY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVEPORY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:17:24 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:18644 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261223AbVEPORV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:17:21 -0400
Message-ID: <4288AB6A.3060106@cosmosbay.com>
Date: Mon, 16 May 2005 16:17:14 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Roberto Fichera <kernel@tekno-soft.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to use memory over 4GB
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it> <428898CF.5060908@cosmosbay.com> <6.2.1.2.2.20050516151659.077cceb0@mail.tekno-soft.it>
In-Reply-To: <6.2.1.2.2.20050516151659.077cceb0@mail.tekno-soft.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 16 May 2005 16:17:15 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Fichera a écrit :

> 
>> But still you need a 4GB/4GB user/kernel split, because the standard 
>> is 3GB/1GB.
> 
> 
> Why I need 4GB/4GB split? What are the beneficts?

Well... 4GB for your process is better than 3GB, that's 33% more space...

If your process is cpu bounded (and not issuing too many system calls),
then 4GB/4GB split let it address more ram, reducing the need to shift windows in
mmaped files for example.

Eric



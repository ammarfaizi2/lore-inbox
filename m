Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVEPM6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVEPM6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVEPM6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:58:16 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:17334 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261601AbVEPM6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:58:01 -0400
Message-ID: <428898CF.5060908@cosmosbay.com>
Date: Mon, 16 May 2005 14:57:51 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Roberto Fichera <kernel@tekno-soft.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to use memory over 4GB
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
In-Reply-To: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 16 May 2005 14:57:51 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Fichera a écrit :
> Hi All,
> 
> I've a dual Xeon 3.2GHz HT with 8GB of memory running kernel 2.6.11.
> I whould like to know the way how to use all the memory in a single
> process, the application is a big simulation which needs big memory 
> chuncks.

AFAIK the best you can have with a 32bits processor, is 4GB for one process.

But still you need a 4GB/4GB user/kernel split, because the standard is 3GB/1GB.

Eric

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWEVEjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWEVEjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 00:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWEVEjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 00:39:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:27052 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750903AbWEVEjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 00:39:36 -0400
Message-ID: <44714080.6020303@us.ibm.com>
Date: Sun, 21 May 2006 21:39:28 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@lst.de, bcrl@kvack.org, cel@citi.umich.edu, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/4] Remove readv/writev methods and use aio_read/aio_write instead
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>	<1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>	<1147728133.6181.2.camel@dyn9047017100.beaverton.ibm.com> <20060521180037.3c8f2847.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
>>This patch removes readv() and writev() methods and replaces
>> them with aio_read()/aio_write() methods.
>>
>
>And it breaks autofs4
>
>autofs: pipe file descriptor does not contain proper ops
>

Yuck. I will take a look. Unfortunately, I am travelling next week.
It will have to wait for atleast 10 days or so. :(

Thanks,
Badari

>



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbSITJKv>; Fri, 20 Sep 2002 05:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261964AbSITJKv>; Fri, 20 Sep 2002 05:10:51 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:39947 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S261954AbSITJKv>;
	Fri, 20 Sep 2002 05:10:51 -0400
Message-ID: <3D8AE719.5000901@corvil.com>
Date: Fri, 20 Sep 2002 10:15:05 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: ext3 fs: no userspace writes == no disk writes ?
References: <200209200909.g8K99qo04297@verdi.et.tudelft.nl>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob van Nieuwkerk wrote:
> Hi P�draig,
> 
> P�draig Brady wrote:
> 
>>Rob van Nieuwkerk wrote:
>>
>>>Hi Alan,
>>>
>>>
>>>>On Fri, 2002-09-20 at 00:04, Andrew Morton wrote:
>>>>
>>>>
>>>>>There are frequently written areas of an ext3 filesystem - the
>>>>>journal, the superblock.  Those would wear out pretty quickly.
>>>>
>>>>CF is -supposed- to wear level.
>>>
>>>Yes I know.
>>>
>>>But I haven't been able to find any specs from any CF manufacturer
>>>about this mechanism, percentage of spare sectors or number of allowed
>>>write-cycles in general.
>>
>>me either.
>>
>>Why don't you just mount the fs ro ?
>>
>>P�draig
> 
> 
> Ehm .., because I need to store data on it ..

Ehm, well remount,rw before you store data on it
and remount,ro when finished?

P�draig.


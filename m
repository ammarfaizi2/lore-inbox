Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261848AbSJUO2O>; Mon, 21 Oct 2002 10:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266538AbSJUO2O>; Mon, 21 Oct 2002 10:28:14 -0400
Received: from k100-128.bas1.dbn.dublin.eircom.net ([159.134.100.128]:1806
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S266533AbSJUO2N>; Mon, 21 Oct 2002 10:28:13 -0400
Message-ID: <3DB41002.2050204@corvil.com>
Date: Mon, 21 Oct 2002 15:32:34 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Robert Love <rml@tech9.net>, akpm@digeo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: benchmarks of O_STREAMING in 2.5
References: <1034823201.722.429.camel@phantasy> <1035211132.27309.131.camel@irongate.swansea.linux.org.uk>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-10-17 at 03:53, Robert Love wrote:
> 
>>I gave the O_STREAMING in Andrew's 2.5-mm tree the treatment..
>>
>>Short summary: It works.
>>
>>The streaming read test in the following benchmarks is simply a read()
>>in 64KB byte chunks of an 800MB file.
> 
> All you now need to do is make it work with an API thats usable by the
> other 99% of real world apps, is extensible and sensible ways and
> therefore can be used.

I'm confused. Isn't this just an O_STREAM flag on open/fcntl ?
How could it be simpler? I suppose the VM could do better than
it currently does automatically but there is no harm in the app
giving a hint like this thus allowing stuff to be dropped from
the cache more aggresively?

Pádraig.


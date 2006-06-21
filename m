Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWFUI1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWFUI1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWFUI1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:27:31 -0400
Received: from tedsautoline.com ([69.222.0.225]:46820 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S932491AbWFUI1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:27:30 -0400
Message-ID: <20060621031742.7tlid5zm4kgg4488@69.222.0.225>
Date: Wed, 21 Jun 2006 03:17:42 -0500
From: art@usfltd.com
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-x64-smp-multiprocessor-time util problem
References: <20060619180413.qlgd1oj9etmosckg@69.222.0.225>
	<1150759021.3043.33.camel@gimli.at.home>
In-Reply-To: <1150759021.3043.33.camel@gimli.at.home>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bernd Petrovitsch <bernd@firmix.at>:

> On Mon, 2006-06-19 at 18:04 -0500, art@usfltd.com wrote:
>> on dual core amd-athlon under 64bit-smp core
>>
>> kernel compilation time:
>>
>> time make -j 8
>> ...
>> LD [M]  sound/usb/snd-usb-lib.ko
>> LD [M]  sound/usb/usx2y/snd-usb-usx2y.ko
>>
>> real    18m0.948s
>> user    26m6.270s    ------bad
>> sys     4m22.256s    ------?bad
>> [xxx@localhost linux-2.6.17]$
>> --- real-clock time  is ~18 min -- user and system time doubled?
>
> How many virtual CPUs (i.e. HT is "2 CPUs") do you have in that machine?
>
> 	Bernd
> --
> Firmix Software GmbH                   http://www.firmix.at/
> mobil: +43 664 4416156                 fax: +43 1 7890849-55
>           Embedded Linux Development and Services
>
------------------------------------------------

1 CPU 2 cores = 2 (amd athlon x2 4200+)

xboom

art@usfltd.con

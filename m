Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbTAORDX>; Wed, 15 Jan 2003 12:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbTAORCN>; Wed, 15 Jan 2003 12:02:13 -0500
Received: from intra.cyclades.com ([64.186.161.6]:17933 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S266837AbTAORCH>; Wed, 15 Jan 2003 12:02:07 -0500
Message-ID: <3E25254A.9050307@cyclades.com>
Date: Wed, 15 Jan 2003 09:09:30 +0000
From: Henrique Gobbi <henrique2.gobbi@cyclades.com>
Reply-To: henrique.gobbi@cyclades.com
Organization: Cyclades Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add module reference to struct tty_driver
References: <20030113054708.GA3604@kroah.com> <20030114200719.B4077@flint.arm.linux.org.uk> <20030114220859.GA17226@kroah.com> <20030115100001.D31372@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !!!

Noob question !!

Could anyone contribute to my poor kernel knowledge base and explain me 
what is BKL you're all talking about ?

thank you
Henrique

Russell King wrote:
> On Tue, Jan 14, 2003 at 02:08:59PM -0800, Greg KH wrote:
> 
>>Woah!  Hm, this is going to cause lots of problems in drivers that have
>>been assuming that the BKL is grabbed during module unload, and during
>>open().  Hm, time to just fallback on the argument, "module unloading is
>>unsafe" :(
> 
> 
> Note that its the same in 2.4 as well.  iirc, the BKL was removed from
> module loading/unloading sometime in the 2.3 timeline


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289240AbSAVKu4>; Tue, 22 Jan 2002 05:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289260AbSAVKuq>; Tue, 22 Jan 2002 05:50:46 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:39921 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289240AbSAVKuc>;
	Tue, 22 Jan 2002 05:50:32 -0500
Message-ID: <3C4D4366.9020406@debian.org>
Date: Tue, 22 Jan 2002 11:48:06 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: CML2-2.1.3 is available
In-Reply-To: <15312.1011695148@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jan 2002 10:50:31.0344 (UTC) FILETIME=[9C8FB300:01C1A332]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> 
> All the make *config entries generate include/linux/autoconf.h, it is
> the C representation of .config.  Some people may think that autoconf.h
> is created by make autoconfig when it is really created by all *config
> steps.
> 
 
I know.

My question: where do you find

autoconf autoconfigure: symlinks
    $(SHELL_SCRIPT) script/...


This can cause confution, but I don't find ut in the sources.

BTW: I used 'make autoprobe' because of possible confutions, in

latter version. Now Eric will use both 'make autoconfig' and
'make autoprobe'.
The choice of name now is on Eric hands. Important is that
*users* doesn't confuse it.

	giacomo




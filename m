Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290423AbSBSH7E>; Tue, 19 Feb 2002 02:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290445AbSBSH6x>; Tue, 19 Feb 2002 02:58:53 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:28165 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S290423AbSBSH6n>;
	Tue, 19 Feb 2002 02:58:43 -0500
Message-ID: <3C7204F3.7040601@debian.org>
Date: Tue, 19 Feb 2002 08:55:31 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <fa.i4fkbuv.1k1iiqm@ifi.uio.no> <fa.iuo8icv.19g8gre@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Feb 2002 07:58:41.0288 (UTC) FILETIME=[3EDB0080:01C1B91B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthias Andree wrote:

> On Sat, 16 Feb 2002, Nicolas Pitre wrote:
> 
> 
>>Make the whole thing ___***IDENTICAL***___ to CML1.
>>Do a formal translation of CML1 into CML2.
>>
> 
> This requirement is contrary to CML2's objective. CML2 is not about
> re-implementing CML1 tools and bugs in another language, there are at
> least two current projects for that, one of them is mconfig.


But making the translation in 3 steps make think easier:
- Change the engine (CML2), the rules are rewritten, but
   functionally nearly identical to old rules
   (Big patch)
- Change the rules (with a lot of small patches)
- Change the interface (not really need)

	giacomo


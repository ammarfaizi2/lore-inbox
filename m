Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264196AbUFPWst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUFPWst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbUFPWst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:48:49 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39616 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S264196AbUFPWsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:48:46 -0400
X-Sasl-enc: 3AHCz6nA7k87ws8bhBw8mw 1087426125
Message-ID: <40D0CE4B.6070708@mailcan.com>
Date: Thu, 17 Jun 2004 00:48:43 +0200
From: Leon Woestenberg <leonw@mailcan.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PROBLEM: 2.6.7 does not compile (jfs errors)
References: <20040616133944.GA1987@8128.biz> <1087403262.29041.25.camel@shaggy.austin.ibm.com> <Pine.GSO.4.58.0406161856190.1249@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0406161856190.1249@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Geert Uytterhoeven wrote:
> On Wed, 16 Jun 2004, Dave Kleikamp wrote:
>>On Wed, 2004-06-16 at 08:39, Perlbroker wrote:
>>>fs/jfs/jfs_dtree.c:389: `temp_table' undeclared (first use in this function)
>>This was reported in another thread by Tomas Szepe.  I don't know why
>>this sometimes compiles cleanly, but this patch should fix it:
> Because newer gcc allows declarations of variables between statements, while
> older doesn't?
> 
Yep, the C99 edition of the C standard allows this.

I do not know when GCC started to support this particular C99 'feature' 
but we may see it popping op more often when "newer gcc"-only developers
commit.

Regards,

Leon.

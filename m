Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269299AbRGaNyF>; Tue, 31 Jul 2001 09:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269300AbRGaNxz>; Tue, 31 Jul 2001 09:53:55 -0400
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:8832 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S269299AbRGaNxo>; Tue, 31 Jul 2001 09:53:44 -0400
Message-ID: <3B66B838.C8B427B1@acm.org>
Date: Tue, 31 Jul 2001 23:52:56 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulr <reichp@ameritech.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 -- GCC-3.0 -- "multiline string literals deprecated" -- PATCH
In-Reply-To: <3B663AC9.3A290C32@ameritech.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

paulr wrote:
> 
> Folks,
> 
> While building both kernels 2.4.6 and 2.4.7,
> I encountered a series of compiler warnings,
> 
> warning: multiline string literals are deprecated.
> 
> The build environment was gcc3.0 and binutils-2.11.2.

Yes, unfortunately GCC 3.0 deprecated multiline string literals -- I saw
someone arguing on the GCC mailing lists that writing large chunks of
inline asm shouldn't be "easy", as it interferes with the compiler's
optimization passes.  There were other such braindead arguments
supporting the deprecation.  The thread should be pretty easy to find in
the archives.  Don't know if the deprecation will be removed in future
versions.

-- Gareth

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbSJaQ3x>; Thu, 31 Oct 2002 11:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJaQ3w>; Thu, 31 Oct 2002 11:29:52 -0500
Received: from main.gmane.org ([80.91.224.249]:16063 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S262886AbSJaQ3K>;
	Thu, 31 Oct 2002 11:29:10 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: The Ext3sj Filesystem
Date: Thu, 31 Oct 2002 11:36:36 -0500
Message-ID: <aprm29$flg$2@main.gmane.org>
References: <200210301434.17901.mattf@mattjf.com> <Pine.LNX.4.44L.0210301826410.1697-100000@imladris.surriel.com>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1036082057 16048 130.127.121.177 (31 Oct 2002 16:34:17 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Thu, 31 Oct 2002 16:34:17 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Wed, 30 Oct 2002, Matthew J. Fanto wrote:
> 
>> I am annoucing the development of the ext3sj filesystem. Ext3sj is a new
>> encrypted filesystem based off ext3. Ext3sj is an improvement over the
>> current loopback solution because we do not in fact require a loopback
>> device.  [snip]  Instead, every file is encrypted seperately
> 
> Very nice, for exactly the reasons you outlined ;)
> 
>> Currently, ext3sj supports the following algorithms: AES, 3DES, Twofish,
>> Serpent, RC6, RC5, RC2, Blowfish, CAST-256, XTea, Safer+, SHA1, SHA256,
>> SHA384, SHA512, MD5, with more to come.  If anyone has any comments,
> 
> How about using the algorithms that are already in the kernel
> via the crypto API so all of the kernel can share the same
> crypto algorithms ?

I agree, as this seems like the logical approach.  However, why not just add 
the missing algorithms in the list above to the CryptoAPI while your at it?  
That way, we really give users a choice over which algorithm they prefer to 
use, but also maintaining a centralized API for them.

Cheers,
Nicholas



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSENSAf>; Tue, 14 May 2002 14:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315945AbSENSAd>; Tue, 14 May 2002 14:00:33 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:39282 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315944AbSENSAb>; Tue, 14 May 2002 14:00:31 -0400
Date: Tue, 14 May 2002 13:00:23 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205141800.NAA73317@tomcat.admin.navo.hpc.mil>
To: mark@mark.mielke.cc, Elladan <elladan@eskimo.com>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Cc: Christoph Hellwig <hch@infradead.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke <mark@mark.mielke.cc>:
> 
> Notice how the space can only be filled up if a setuid program is used
> to actually fill it up. Even if it is a partial 'security feature', every
> administrator knows that setuid violates security in a non-natural way.

Actually, any existing daemon (read "syslog") can use this space. This is
partly why it is a "security feature" so that the logs can still get to disk
even if the filesystem is "full".

> 1) Provide a patch and see if it is accepted.

Patch not necessary - it is a tuneable feature. All that is missing is
an understanding of what the reservation is/can be used for.

> 2) Convince somebody else that they should put time into features of
>    questionable value such as this one.

Already done - see "man tune2fs".

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

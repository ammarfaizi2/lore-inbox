Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291547AbSCMBLP>; Tue, 12 Mar 2002 20:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSCMBLF>; Tue, 12 Mar 2002 20:11:05 -0500
Received: from quechua.inka.de ([212.227.14.2]:56112 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S291547AbSCMBKu>;
	Tue, 12 Mar 2002 20:10:50 -0500
From: Bernd Eckenfels <ecki-news2002-02@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
In-Reply-To: <3C8E8912.64435C1E@us.ibm.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16kxI2-0003aI-00@sites.inka.de>
Date: Wed, 13 Mar 2002 02:10:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C8E8912.64435C1E@us.ibm.com> you wrote:
> I assume that you mean do the nasty stuff but never have anything in
> your
> event log indicating that it happened.  Good point, but if the buffer is
> sized appropriately for the incoming volume of events and the logging
> daemon 
> is reading the events out of the kernel buffer (as should normally be
> the case), 
> then you would see the events.  

Well, depending on the type of events one can even think about a "halt" like
it is required for audit trail overflow.

What would be nice is a policy for each type of event:

- overwrite old/new/halt
- rate limit
- buffer size

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRHWDEX>; Wed, 22 Aug 2001 23:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272198AbRHWDEM>; Wed, 22 Aug 2001 23:04:12 -0400
Received: from [24.130.1.20] ([24.130.1.20]:25031 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S272197AbRHWDEB>; Wed, 22 Aug 2001 23:04:01 -0400
Message-ID: <3B847295.5127D1F8@kegel.com>
Date: Wed, 22 Aug 2001 20:03:49 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: socket connected to itself with RH 2.2.14-5.0? (Problem with example 
 from Stevens)
In-Reply-To: <3B82C7F2.43A60829@kegel.com> <20010822120619.A13189@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> 
> On Tue, Aug 21, 2001 at 01:43:30PM -0700, Dan Kegel wrote:
> > tcp        0      0 127.0.0.1:2003          127.0.0.1:2003          ESTABLISHED 965/client
> >
> > Erm, could the client have connected to *itself* somehow?
> 
> I would not consider that a bug even though certainly not very helpful.
> Now I wonder if this could potencially be abused for nice DoS attacks ...

After running the server on a port not in the ephemeral range,
the problem goes away.  It's just a funny thing that can happen
when you're connecting to a server on your own box, so no big deal.
- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263327AbTJKRD6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTJKRD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:03:57 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:9638 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263327AbTJKRDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:03:55 -0400
Message-ID: <3F8837FA.4090808@softhome.net>
Date: Sat, 11 Oct 2003 19:03:54 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: asdfd esadd <retu834@yahoo.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 thoughts: common well-architected object model 
References: <Ft4B.3ML.3@gated-at.bofh.it> <FutO.5TB.29@gated-at.bofh.it>
In-Reply-To: <FutO.5TB.29@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

asdfd esadd wrote:
> the other OS has an at this stage highly consistent
> object model user along the lines of COM+ from the
> kernel up encompassing a single event, thread etc.
> model. Things are quite consistently wrapped, user
> mode exposed if needed etc. If people were to fully
> draw on it and the simpler .net BCL and not ride win32
> that would (will be) a killer.  
> 
> So let me restate the need:
> 
> * a unified well architected core component model
> which is extensible from OS services to application
> objects
> 
> * the object model should be defined from the kernel
> layer for process/events/devices etc. up and not
> started at the application layer
> 

   Hm.

   Any real world application for which POSIX is not enough?
   Any real world application which can benefit /enourmosly/ from this?

   State, please, problem first - do not put the requirements ahead of 
problem.

   Since as of event system I would say POSIX (and Linux in particular) 
far ahead of permanently inconsistent Win32.
   [ Win32 is a very bad example, since you have there a "spawn one more 
thread" solution/workaround for any problem. Try to read MSDN by yourself. ]

P.S. <kidding> Probably Java is what you are looking for? (java.* after 
all some kind of kernel for Java, and jvm is some kind of cpu ;-)))) 
</kidding>

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML


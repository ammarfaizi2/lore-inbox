Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271931AbRIVStk>; Sat, 22 Sep 2001 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271935AbRIVStb>; Sat, 22 Sep 2001 14:49:31 -0400
Received: from ohiper1-80.apex.net ([209.250.47.95]:3081 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S271931AbRIVSt2>; Sat, 22 Sep 2001 14:49:28 -0400
Date: Sat, 22 Sep 2001 13:48:58 -0500
From: Steven Walter <srwalter@yahoo.com>
To: wolfgang buesser <wolfgang_buesser@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ftape 4.0x and Kernel 2.4.x
Message-ID: <20010922134858.A3500@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	wolfgang buesser <wolfgang_buesser@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010922181004.54680.qmail@web13307.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010922181004.54680.qmail@web13307.mail.yahoo.com>; from wolfgang_buesser@yahoo.com on Sat, Sep 22, 2001 at 11:10:04AM -0700
X-Uptime: 1:43pm  up 2 days, 21:49,  2 users,  load average: 2.38, 1.77, 1.59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 11:10:04AM -0700, wolfgang buesser wrote:
> What is the status of the integration of ftape 4.0x
> into kernel 2.4.x?
> 
> I am using a Conner 3200 MB Travan 3 Streamer which
> does not work properly with ftape 3.04.
> I tried to compile ftape4.04a into kernel 2.4.9
> using gcc 2.96 and libc-2.2.2 but get tons of errors
> (the patch by stephen walter does not work either).
> 
> Any advise ?

This looks to be caused, at least in part, by the new in-kernel min/max
macros, which ftape wasn't intended to use.

I'm not sure what the development status is of ftape.  Perhaps a
newer/CVS version is availible that is more in-sync with the current
kernel tree?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell

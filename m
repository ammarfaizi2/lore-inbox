Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSEQJIR>; Fri, 17 May 2002 05:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSEQJIQ>; Fri, 17 May 2002 05:08:16 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:40150 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S315485AbSEQJIP>; Fri, 17 May 2002 05:08:15 -0400
Message-ID: <3CE4C895.EB34A245@cisco.com>
Date: Fri, 17 May 2002 14:38:37 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.51C-CISCOENG [en] (X11; I; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank Schaefer <frank.schafer@setuza.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: counters
In-Reply-To: <3CE3BECB.FF1AE6A@ail.com> <1021614923.253.0.camel@ADMIN>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Thanks for your response. What i meant was 
	every process could have an account of how
	many bytes were read/written to various
	filesystems/sockets using read()/write()
	system calls. 

	We could dump this stuff in /proc and
	it could tell us which processes are
	heavily IO bound.

	I am wondering if this information will
	be useful to anyone.

Frank Schaefer wrote:
> 
> On Thu, 2002-05-16 at 16:14, Manik Raina wrote:
> > anyone knows if there are counters in the linux kernel
> > which can be read via /proc like mechanism for the
> > following :
> >
> > 1. total number of bytes read by process by syscalls
> > like read()
> >
> > 2. total number of bytes written by each process by
> > syscalls like write()
> 
> Hi,
> 
> as far as I know there's not a ready to use counter in the procfs.
> 
> BTW: What do you want to count? Do You mean timers?
> 
> It shouldn't be a problem, to write a little driver, which could make
> this available.
> 
> Regards
> Frank
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSDIPMm>; Tue, 9 Apr 2002 11:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293092AbSDIPMl>; Tue, 9 Apr 2002 11:12:41 -0400
Received: from air-2.osdl.org ([65.201.151.6]:27921 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S293048AbSDIPMk>;
	Tue, 9 Apr 2002 11:12:40 -0400
Date: Tue, 9 Apr 2002 08:09:48 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Frank Schaefer <frank.schafer@setuza.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: syscals
In-Reply-To: <1018346790.680.10.camel@ADMIN>
Message-ID: <Pine.LNX.4.33L2.0204090809020.22258-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Apr 2002, Frank Schaefer wrote:

| On Tue, 2002-04-09 at 04:10, mark manning wrote:
| > ok - according to unistd.h we now have exactly 256 syscalls allocated (unless im missing something).  my code needs to be able to account for every single possible syscall and so i need to be able to store the syscall number in a standard way.  not all syscalls are catered for on the outset by at any time the user can say "i need to use syscall x which takes y parameters" and the code will be able to take care of it.
| >
| > the problem is that i am currently reserving only 8 bits for the syscall number.  this is ok for now but if we ever get another syscall its going to be unuseable by my existing code :) - should i be reserving 16 bits now in preperation for some new syscalls being added ?
| > -
| >
| Hmm...
|
| dunno if you got this right. There are maximal 256 syscalls possible,
| and, right -- exactly this amount of syscalls is in the entrytable. But
| alotalotalot of them are defined as sys_ni_syscall (not yet
| implemented).
| I think there is still some space for enhancements. See
| arch/i386/kernel/entry.S.

Where is the limitation of 256 syscalls possible?

-- 
~Randy


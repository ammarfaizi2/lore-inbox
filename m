Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265117AbSKEGCe>; Tue, 5 Nov 2002 01:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSKEGCe>; Tue, 5 Nov 2002 01:02:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:24979 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265117AbSKEGCd>; Tue, 5 Nov 2002 01:02:33 -0500
Date: Mon, 04 Nov 2002 22:05:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alexander Viro <viro@math.psu.edu>
cc: andersen@codepoet.org, Werner Almesberger <wa@almesberger.net>,
       jw schultz <jw@pegasys.ws>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ps performance sucks (was Re: dcache_rcu [performance results])
Message-ID: <3839636935.1036447528@[10.10.2.3]>
In-Reply-To: <Pine.GSO.4.21.0211050056170.2336-100000@steklov.math.psu.edu>
References: <Pine.GSO.4.21.0211050056170.2336-100000@steklov.math.psu.edu>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well it can't be any worse than the current crap. At least it'd 
>> stand a chance in hell of scaling a little bit. So I took a very 
>> quick look ... what syscalls are you reduced to per pid, one ioctl 
>> and one read?
> 
> Oh, yes it can.  Easily.
> 	* device is not network-transparent - even in principle

Is that really a major issue for ps?

> 	* restricting data access would be harder - welcome to suid or
> sgid country

I can live with that level of pain if my benchmark doesn't get
driven into the wall by the tools that are meant to be montoring
it ...

I'm sure there are bigger rocks to be thrown at it as well, and
ugly critters to be found under those rocks, but I don't see anything
insurmountable here yet. Whereas opening billions of files is just
unworkable.

Better still, you seem like an excellent candidate to propose a good 
design that's efficient and workable? 

> 	* real killer: you think Albert would fail to produce equally
> crappy code and equally crappy behaviour?  Yeah, right.

Heh ;-) 
A hostile takeover might suffice here, if necessary ...

M.


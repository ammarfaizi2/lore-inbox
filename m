Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSACXDX>; Thu, 3 Jan 2002 18:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288371AbSACXDD>; Thu, 3 Jan 2002 18:03:03 -0500
Received: from fungus.teststation.com ([212.32.186.211]:37127 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S286893AbSACXC5>; Thu, 3 Jan 2002 18:02:57 -0500
Date: Fri, 4 Jan 2002 00:02:45 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Dan Kegel <dank@kegel.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] smbfs fsx'ed
In-Reply-To: <3C34E061.3455AE74@kegel.com>
Message-ID: <Pine.LNX.4.33.0201032351440.28529-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Dan Kegel wrote:

> I use smbfs to mount a visual sourcesafe database,
> and run ss via wine.  The combination is very slow.
> Don't know how much of it is wine, and how much is smbfs,
> but any speedup would be greatly appreciated.

SS is really painful on a high latency connection, CVS is a wonder of
efficiency in comparison. At least that is my experience. But that is
probably not your setup.
(and yes, I understood that you compared with windows performance)

You may want to know that smbfs does not do any file locking. I don't know
if SS depends on that or not. I do know that some people have tried
running dos based database programs in dosemu accessing a database over
smbfs with database corruption as a result.


> (Eventually, wine will bundle its own smb code, but for
> now if you want to access network shares, smbfs is the only way.)
> - Dan
> 
> p.s. see http://www.kegel.com/linux/vss-howto.html

Very nice. The commandline SS client would never work for me under wine.
I'll have to try that again.

/Urban


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbRAIB3d>; Mon, 8 Jan 2001 20:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbRAIB3X>; Mon, 8 Jan 2001 20:29:23 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:4615
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S129775AbRAIB3O>; Mon, 8 Jan 2001 20:29:14 -0500
Date: Mon, 8 Jan 2001 20:37:22 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Benson Chow <blc@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Message-ID: <20010108203722.B10936@animx.eu.org>
In-Reply-To: <20010108225451.A968@stefan.sime.com> <Pine.LNX.4.31.0101081501560.10554-100000@q.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.31.0101081501560.10554-100000@q.dyndns.org>; from Benson Chow on Mon, Jan 08, 2001 at 03:11:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not very portable at all...
> 
> hpux = HP/UX 10.2
> 
> hpux:~$ mkdir foo
> hpux:~$ cd foo
> hpux:~/foo$ rmdir "`pwd`"
> rmdir: /home/blc/foo: Cannot remove mountable directory
> hpux:~/foo$ rmdir .
> rmdir: cannot remove .. or .
> hpux:~/foo$ rmdir /home/blc/foo
> rmdir: /home/blc/foo: Cannot remove mountable directory
> hpux:~/foo$ rmdir ./
> rmdir: ./: Cannot remove mountable directory
> hpux:~/foo$
> 
> Maybe HP/UX is messed up as well.

Nor solaris
[wakko@<removed>:/home/wakko/test] rmdir "`pwd`"
rmdir: /home/wakko/test: Invalid argument
[wakko@<removed>:/home/wakko/test] uname -a
SunOS <removed> 5.8 Generic_108528-03 sun4d sparc SUNW,SPARCcenter-2000
[wakko@<removed>:/home/wakko/test] 


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

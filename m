Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263968AbSK0B6E>; Tue, 26 Nov 2002 20:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSK0B6E>; Tue, 26 Nov 2002 20:58:04 -0500
Received: from talus.maths.usyd.edu.au ([129.78.68.1]:36873 "EHLO
	talus.maths.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S263968AbSK0B6E>; Tue, 26 Nov 2002 20:58:04 -0500
Date: Wed, 27 Nov 2002 13:04:04 +1100 (EST)
From: psz@maths.usyd.edu.au (Paul Szabo)
Message-Id: <200211270204.gAR244k330285@milan.maths.usyd.edu.au>
To: bugtraq@securityfocus.com, cliph@isec.pl, linux-kernel@vger.kernel.org,
       security@debian.org, security@isec.pl, vulnwatch@vulnwatch.org
Subject: Re: d_path() truncating excessive long path name vulnerability
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in March 2002, Wojciech Purczynski <cliph@isec.pl> wrote (original
article at http://online.securityfocus.com/archive/1/264117 ):

> Name:		Linux kernel
> Version:	up to 2.2.20 and 2.4.18
> ...
> In case of excessively long path names d_path kernel internal function
> returns truncated trailing components of a path name instead of an error
> value. As this function is called by getcwd(2) system call and
> do_proc_readlink() function, false information may be returned to
> user-space processes.

The problem is still present in Debian 2.4.19 kernel. I have not tried 2.5,
but see nothing relevant in the Changelogs at http://www.kernel.org/ .

Cheers,

Paul Szabo - psz@maths.usyd.edu.au  http://www.maths.usyd.edu.au:8000/u/psz/
School of Mathematics and Statistics  University of Sydney   2006  Australia

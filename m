Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314392AbSEIVmL>; Thu, 9 May 2002 17:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314393AbSEIVmK>; Thu, 9 May 2002 17:42:10 -0400
Received: from pcp490536pcs.nash01.tn.comcast.net ([68.53.1.252]:38797 "EHLO
	ariel.karmak.org") by vger.kernel.org with ESMTP id <S314392AbSEIVmJ>;
	Thu, 9 May 2002 17:42:09 -0400
Date: Thu, 9 May 2002 21:42:08 +0000
From: Michael Carmack <karmak@karmak.org>
To: linux-kernel@vger.kernel.org
Subject: Package management scheme
Message-ID: <20020509214208.GA16821@ariel.karmak.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First, I apologize if this is an inappropriate place for this. I'm not
sure where else to take it.

Over the past year or so I've been working on a way to handle software
installation and management on Linux systems. By rearranging the 
traditional UNIX filesystem hierarchy somewhat, I've come up with 
what I believe to a comprehensive solution to several problems that
users and developers often face.

Briefly, I've organized all packages under a /pkg hierarchy, giving each
one a unique namespace. Package versioning, cross-compilation support,
and the co-existance of packages from multiple distributors is all
supported directly by the filesystem. It's also possible to manage 
everything from source installation to binary distribution using standard
UNIX utilities (no need for things like dpkg/rpm). I've written a dozen
or so shell scripts for this purpose.

I've typed up a more complete description and put it on the Web[1] for
those who are interested. There is also a bootstrap archive (30MB) that 
will let people download and install a subset of the packages I've
compiled, but I don't have the bandwidth to distribute the full package
collection (mirrors anyone?). This bootstrap archive is not for the 
novice. The documentation and software is alpha-quality, so if you decide
to install, proceed with caution.

m.

[1] http://www.karmak.org/2002/04/fs/


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314743AbSEUPgC>; Tue, 21 May 2002 11:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314755AbSEUPgB>; Tue, 21 May 2002 11:36:01 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:23173 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S314743AbSEUPgB>;
	Tue, 21 May 2002 11:36:01 -0400
Date: Tue, 21 May 2002 11:36:01 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Lazy Newbie Question
Message-ID: <Pine.LNX.4.33L2.0205211133180.14445-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whats the best way to do the equivalent of a stat() on a char * pathname
from inside a kernel module?  Don't ask why I need to do this.. I know it
sounds evil but I just need to do it...  Basically I need to find out the
minor number of a device file.

I noticed there's a filp_open() function that is exported and it returns a
struct file *.  I am not sure what the semantics of about 75% of the
fields in that struct are.. and/or how they relate to the well-documented
fields in the libc's struct stat.  Any help/insights would be appreciated.


-Calin


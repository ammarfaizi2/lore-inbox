Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292617AbSCIKWe>; Sat, 9 Mar 2002 05:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292627AbSCIKWO>; Sat, 9 Mar 2002 05:22:14 -0500
Received: from 1Cust55.tnt15.sfo3.da.uu.net ([67.218.75.55]:64525 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S292617AbSCIKWD>;
	Sat, 9 Mar 2002 05:22:03 -0500
Date: Sat, 9 Mar 2002 14:22:33 -0800 (PST)
Message-Id: <200203092222.OAA03372@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




       Val Henson:

       For a laugh, read the instructions on how to "rename" CVS files. 
       Hint: "Rename" is not the correct word. 


       $ mv old new 
       $ cvs remove old 
       $ cvs add new 
       $ cvs commit -m "Renamed old to new" old new 

       [...]  There are two other ways to rename a file in CVS, one of
       which is described as "dangerous" and the other as having
       "drawbacks." References:


       Note that the way to rename a file in in BitKeeper is: 

       $ bk mv old new 

       No danger, no drawbacks, no hand editing of history files. 


I like the arch way of renaming a file:

	$ mv old new

(Yes, history is preserved, etc.)

-t

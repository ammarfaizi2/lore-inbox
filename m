Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311237AbSCQAy4>; Sat, 16 Mar 2002 19:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311231AbSCQAyg>; Sat, 16 Mar 2002 19:54:36 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:40868 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S311229AbSCQAya>; Sat, 16 Mar 2002 19:54:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: linux-kernel@vger.kernel.org
Subject: [BK] Having a hard time updating by pre-patch
Date: Sat, 16 Mar 2002 18:54:00 -0600
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020317005425.TVMQ1147.rwcrmhc52.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First let me describe my goal:  I am trying to get UML working with the 
recent 2.5.x versions.  Currently, the most recent UML patch for 2.5 is 
against 2.5.2-pre11.

What I have done is clone'd http://linux.bkbits.net/linux-2.5 and then cloned 
that to a working repository.  When I cloned I used -r1.157, which is the 
revision 2.5.2-pre11 was.  I then apply the UML patch with bk import.  My 
next step would be to go to rev 1.158 and make sure everything works.  
Provided everything is OK at that step, I would go to the next rev and repeat.

So far I have found two ways to get from 1.157 to 1.158.  One is to pull from 
the parent and then undo down to 1.158.  The only other way that has been 
suggested to me is to pull 1.158 in parallel and then import the patch there.

I have only tried the former with little to no success thus far.  For one 
thing the trees are sparse after I've cloned them, which IIRC is related to 
BK's mode of operation.  After a bk -r co -q the tree seems to be properly 
populated.  Secondly, undoing a revision also undoes any imported patches.  
Finally, sometimes BK has refused to do anything when there are extra files 
lying around.  None of these things are flaws in BK, just indicative of my 
misunderstanding of the tool.

The second method I deem unusable because 1) BK operations are extremely slow 
on my machine (dual p2/400 256 MB ram) and 2) would be extremely wasteful of 
diskspace to have lots of trees laying around (?).

I have read much of the documentation including the user guide, the website 
tutorial, the reference guide and much of the help documentation and the 
solution to my problem is not apparent.  resync seemed to be the closest to 
what I want but it is only useful when creating a repository.  

So, does anyone have any suggestions on how to update revision by revision 
while keeping patches applied?

Thanks in advance,
-- 
akk~


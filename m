Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262754AbTCTW3R>; Thu, 20 Mar 2003 17:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262749AbTCTW2g>; Thu, 20 Mar 2003 17:28:36 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:9351 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262695AbTCTW1S>;
	Thu, 20 Mar 2003 17:27:18 -0500
In-Reply-To: <OFA4093E14.AB316F7E-ON86256CEF.00784F88-86256CEF.0079F340@rchland.ibm.com>
Subject: Re: [LTP] LTP version 20030306
To: "Doug Ramier" <v2cibdr@us.ibm.com>
Cc: "Li Ge" <lge@us.ibm.com>, "Linda Scott" <lindajs@us.ibm.com>,
       linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFF87F61EE.866F342D-ON05256CEF.007A7A40-86256CEF.007C4B4E@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Thu, 20 Mar 2003 16:37:39 -0600
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 03/20/2003 05:38:04 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We have found that in the past several months that the LTP version
appears
> to become "buggier" with each successive release.
I apologize for the large number of "bugs" in the recent releases, but it
was because we added a large amount of new tests in a short amount of time.
Anyone familiar with the history of the LTP knows that the same thing
happened when we added 500+ new testcases after the move from SGI's site a
few years back.

> From the patches that are coming across this list there are an incredible
> number of problems.
Most of these patches were warning cleanup patches.

> After overcoming problems with the compilation, we are getting between 50
> and 130 failures on 64 and 32 bit versions which with 20030206 we had on
> the order of a dozen.
If you send your problems to the ltp-list@lists.sf.net, we would be more
than happy to assist you.  Strangely, we have never seen that many problems
when we receive results on i386, s390, s390x, x86-64, IA64, MIPS, or PPC64.

> I have a few questions:
> 1) Is everyone getting a "large" number of false failures?
I cannot answer for everyone, and I'm not sure what a "large" number means.

> 2) Are the tests checked out before being released by SourceForge?
Yes, we build, install, and run every release of the LTP BEFORE we
announce.  We review the failures and check for any build errors.

> 3) Are the tests only verified on Intel?  How about PowerPC and iSeries?
Unfortunately, we are unable to test each release on every architecture
supported by Linux.  We choose to test the release on i386 archs, because
this is the main architecture of choice and the code is usually "cleaner".
Although we try to execute the LTP on s390 and PPC64 archs, we rely on the
Open Source community to run and test the LTP against other non-i386
archs...and submit patches for problems they find.

> 4) Is there a version released after the release that has the 205 patches
> installed?
No.  However, most of those patches you speak of were compiler warning
cleanups and anyone can anonymously pull the latest copy of the LTP from
our CVS tree.


- Robbie

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 678-9295
Fax: (512) 838-4603
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein


                                                                                                                                              
                      Doug                                                                                                                    
                      Ramier/Rochester/Contr/IB        To:       ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net,          
                      M@IBMUS                           linux-kernel@vger.kernel.org                                                          
                      Sent by:                         cc:       Li Ge/Austin/IBM@IBMUS, Linda Scott/Austin/IBM@IBMUS                         
                      ltp-list-admin@lists.sour        Subject:  [LTP] LTP version 20030306                                                   
                      ceforge.net                                                                                                             
                                                                                                                                              
                                                                                                                                              
                      03/20/2003 04:12 PM                                                                                                     
                                                                                                                                              




We have found that in the past several months that the LTP version appears
to become "buggier" with each successive release.

>From the patches that are coming across this list there are an incredible
number of problems.

After overcoming problems with the compilation, we are getting between 50
and 130 failures on 64 and 32 bit versions which with 20030206 we had on
the order of a dozen.

I have a few questions:
1) Is everyone getting a "large" number of false failures?
2) Are the tests checked out before being released by SourceForge?
3) Are the tests only verified on Intel?  How about PowerPC and iSeries?
4) Is there a version released after the release that has the 205 patches
installed?

Thanks,
Doug Ramier
pSeries /  iSeries Linux Testing
507/253-2186
t/l 553-2186





-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.
Does your code think in ink? You could win a Tablet PC.
Get a free Tablet PC hat just for playing. What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list





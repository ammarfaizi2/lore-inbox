Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131576AbRAKT6i>; Thu, 11 Jan 2001 14:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132541AbRAKT63>; Thu, 11 Jan 2001 14:58:29 -0500
Received: from capricorn.iris.com ([198.112.211.43]:29446 "EHLO
	capricorn.iris.com") by vger.kernel.org with ESMTP
	id <S131576AbRAKT6M>; Thu, 11 Jan 2001 14:58:12 -0500
Subject: Re: linux-2.4.0 scsi problems on NetFinity servers
To: JP Navarro <navarro@mcs.anl.gov>
Cc: linux-kernel@vger.kernel.org, Tim Wright <timw@splhi.com>
X-Mailer: Lotus Notes Build V60_12122000 December 12, 2000
Message-ID: <OFF7FB1A80.74461F2E-ON852569D1.006C1FF2@iris.com>
From: kenbo@iris.com
Date: Thu, 11 Jan 2001 15:00:30 -0500
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on chablis/UNIX/Notes(Build V60_M7_01092001|January 9, 2001) at
 01/11/2001 02:58:48 PM,
	Itemize by SMTP Server on Capricorn/Iris(Build V60_01012001|January 01, 2001) at
 01/11/2001 02:58:07 PM,
	Serialize by Router on Capricorn/Iris(Build V60_01012001|January 01, 2001) at
 01/11/2001 02:58:13 PM,
	Serialize complete at 01/11/2001 02:58:13 PM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent an email to the NetFinity mailing list, and here is there response
after they started testing with 2.4.0.  FYI: I've tried all suggestions
(non-SMP, flag at boot time,...) and none of them have worked yet; I did
see that someone thought they had found an nfs bug and posted a patch for
it, so I'm gonna patch and test next.

Still looking into it )

Thanks!

kenbo

______________________
Firebirds rule, `stangs serve!

Kenneth "kenbo" Brunsen
Iris Associates
----- Forwarded by Ken Brunsen/Iris on 01/11/01 02:37 PM -----
                                                                                                                           
                    "ServeRAID                                                                                             
                    For Linux"           To:     kenbo@iris.com                                                            
                    <ipslinux@us.        cc:                                                                               
                    ibm.com>             Subject:     Re: linux-2.4.0 scsi problems on NetFinity servers                   
                                                                                                                           
                    01/11/01                                                                                               
                    12:38 PM                                                                                               
                                                                                                                           
                                                                                                                           




We have been able to reproduce this problem in our lab ( using ServeRAID )
.    We have also seen this same lockup at least once in a system which did
not contain any ServeRAID ( only Adaptec ).   Our engineers are
investigating this issue at this time and we are also notifying the Red Hat
engineers of the problem.

Thanks for bringing this to our attention.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

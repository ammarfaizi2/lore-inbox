Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271393AbRHOUFS>; Wed, 15 Aug 2001 16:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271394AbRHOUFH>; Wed, 15 Aug 2001 16:05:07 -0400
Received: from www.casdn.neu.edu ([155.33.251.101]:17935 "EHLO
	www.casdn.neu.edu") by vger.kernel.org with ESMTP
	id <S271393AbRHOUEs>; Wed, 15 Aug 2001 16:04:48 -0400
From: "Andrew Scott" <A.J.Scott@casdn.neu.edu>
Organization: Northeastern University
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 15 Aug 2001 16:04:25 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.8 aic7xxx  -- continuous bus resets
Reply-to: A.J.Scott@casdn.neu.edu
Message-ID: <3B7A9D88.23945.BFC66BE@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I thought I'd look at the 2.4.8 kernel while I figure out what's 
wrong with my 2.2.18 installation. The kernel loading gets stuck with 
errors from the aic7xxx driver, which keeps timeing out querying the 
bus looking for non-existant drives, and when it finaly tries to 
query a drive that exists it claims to see bus errors. End result is 
that Linux 2.4.8 never mounts any drives or finishes loading.

The system is an IBM 704 with a built in adaptec aic-7880U 
controller, with two drives on first scsi buss. 

2.2.18 has no problems with the adaptec controllers, but has other 
issues, which seem to be timer related.



                      _
                     / \   / ascott@casdn.neu.edu
                    / \ \ /
                   /   \_/

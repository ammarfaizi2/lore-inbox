Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRGYTty>; Wed, 25 Jul 2001 15:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266428AbRGYTto>; Wed, 25 Jul 2001 15:49:44 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:1468 "EHLO
	e33.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262715AbRGYTtd>; Wed, 25 Jul 2001 15:49:33 -0400
Importance: Normal
Subject: Re: *very* strange heisenbug (kernel? libc?) 
To: linux-kernel@vger.kernel.org
Cc: david.madore@ens.fr, Ed.Connell@sas.com, jbarkal@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OFABC710C2.8C05140F-ON88256A94.006BEA68@boulder.ibm.com>
From: "James Washer" <washer@us.ibm.com>
Date: Wed, 25 Jul 2001 12:48:43 -0700
X-MIMETrack: Serialize by Router on D03NM038/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 07/25/2001 01:49:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Almost certainly, the bug you are experiencing is the same bug we reported
yesterday under the subject "switch_mm() can fail to load ldt on SMP".

We've written the fix, and are testing it now... Should be available by end
of business today.


 - jim

washer@us.ibm.com





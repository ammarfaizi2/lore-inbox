Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131276AbRDHXbw>; Sun, 8 Apr 2001 19:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRDHXbm>; Sun, 8 Apr 2001 19:31:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38051 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131276AbRDHXbe>; Sun, 8 Apr 2001 19:31:34 -0400
Importance: Normal
Subject: Zero Copy IO
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF31086D36.2158EA0D-ON87256A28.008001ED@LocalDomain>
From: "Alex Q Chen" <aqchen@us.ibm.com>
Date: Sun, 8 Apr 2001 16:31:27 -0700
X-MIMETrack: Serialize by Router on D03NM080/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/08/2001 05:31:29 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to find a way to pin down user space memory from kernel, so
that these user space buffer can be used for direct IO transfer or
otherwise known as "zero copying IO".  Searching through the Internet and
reading comments on various news groups, it would appear that most
developers including Linus himself doesn't believe in the benefit of "zero
copying IO".  Most of the discussion however was based on network card
drivers.  For certain other drivers such as SCSI Tape driver, which need to
handle great deal of data transfer, it would seemed still be more
advantageous to enable zero copy IO than copy_from_user() and copy_to_user
() all the data.  Other OS such as AIX and OS2 have kernel functions that
can be used to accomplish such a task.  Has any ground work been done in
Linux 2.4 to enable "zero copying IO"?

Thanks in advance for any suggestions or comments

Sincerely,
Alex Chen

IBM SSD Device Driver Development
Office: 9000 S. Rita Rd 9032/2262
Email: aqchen@us.ibm.com
Phone: (external) 520-799-5212 (Tie Line) (321)-5212


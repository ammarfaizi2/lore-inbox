Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSFSHLp>; Wed, 19 Jun 2002 03:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317800AbSFSHLo>; Wed, 19 Jun 2002 03:11:44 -0400
Received: from ccs.covici.com ([209.249.181.196]:29569 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S317799AbSFSHLo>;
	Wed, 19 Jun 2002 03:11:44 -0400
To: linux-kernel@vger.kernel.org
Subject: ppp not working properly in 2.5.22
From: John Covici <covici@ccs.covici.com>
Date: Wed, 19 Jun 2002 03:11:44 -0400
Message-ID: <m34rfzagjz.fsf@ccs.covici.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I was using kernel 2.5.22 with ppp as a built in rathr than
modules and after about a half hour of being up I got the following:

Jun 18 13:01:30 ccs pppd[431]: Hangup (SIGHUP)
Jun 18 13:01:30 ccs pppd[431]: Modem hangup
Jun 18 13:01:30 ccs pppd[431]: Connection terminated.
Jun 18 13:01:30 ccs pppd[431]: Connect time 36.4 minutes.
Jun 18 13:01:30 ccs pppd[431]: Sent 738466 bytes, received 1379064 bytes.
Jun 18 13:01:30 ccs pppd[431]: Couldn't release PPP unit: Invalid argument

Whenever pppd would try to redial and establish a connection I got
the folowing endlessly:

Jun 18 13:02:24 ccs pppd[431]: Serial connection established.
Jun 18 13:02:24 ccs pppd[431]: Couldn't create new ppp unit: Inappropriate ioctl for device
Jun 18 13:02:24 ccs pppd[431]: Hangup (SIGHUP)


Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com

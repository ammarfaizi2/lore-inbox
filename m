Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131524AbQKCUZ3>; Fri, 3 Nov 2000 15:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131689AbQKCUZT>; Fri, 3 Nov 2000 15:25:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60167 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131524AbQKCUZB>; Fri, 3 Nov 2000 15:25:01 -0500
Message-ID: <3A031E37.4808BF8D@timpanogas.org>
Date: Fri, 03 Nov 2000 13:21:11 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: 2.2.18pre19 RPC NFS Errors/2.4.0 Lockup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

The 2.2.18pre-19 build does not reproduce this problem with NFS RPC
timeouts, and Andre has merged his patches for our next release, and I
am unable to reproduce it.  In fact, it's running great.   I did have
NDS eDirectory installed on this box when I saw the problem, and without
this software loaded, it seems to be gone.  I think it may be related to
eDirectory in some way (top is reporting some busy process in
eDirectory).  I held off posting the release to reverify the 2.2.18pre18
problems, and to get Andre's patches into the release.   We will go out
with 2.2.18pre-19 at this point.   

Also, I am seeing a lockup on 2.4.0-10 with uniprocessor PPro systems
with SMP enabled, but it runs great on a 4xPPro system with SMP (???). 
I rebuilt with SMP=N and it also ran great.  One for H. Peter Anvin I
think ....

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

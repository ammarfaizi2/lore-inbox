Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318074AbSGWOim>; Tue, 23 Jul 2002 10:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSGWOim>; Tue, 23 Jul 2002 10:38:42 -0400
Received: from ccs.covici.com ([209.249.181.196]:37002 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S318074AbSGWOim>;
	Tue, 23 Jul 2002 10:38:42 -0400
To: linux-kernel@vger.kernel.org
Subject: is flock broken in 2.4 or 2.5 kernels or what does this mean?
From: John Covici <covici@ccs.covici.com>
Date: Tue, 23 Jul 2002 10:41:51 -0400
Message-ID: <m37kjmik0g.fsf@ccs.covici.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest release notes of sendmail I have read the following:

		NOTE: Linux appears to have broken flock() again.  Unless
			the bug is fixed before sendmail 8.13 is shipped,
			8.13 will change the default locking method to
			fcntl() for Linux kernel 2.4 and later.  You may
			want to do this in 8.12 by compiling with
			-DHASFLOCK=0.  Be sure to update other sendmail
			related programs to match locking techniques.

Can anyone tell me what this is all about -- is there any basis in
reality for what they are saying?

Thanks.

-- 
         John Covici
         covici@ccs.covici.com

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144124AbRBWUkF>; Fri, 23 Feb 2001 15:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRBWUc1>; Fri, 23 Feb 2001 15:32:27 -0500
Received: from UX4.SP.CS.CMU.EDU ([128.2.198.104]:57932 "HELO
	ux4.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S129394AbRBWUcR>;
	Fri, 23 Feb 2001 15:32:17 -0500
Message-ID: <3A96C858.5C8FB714@cs.cmu.edu>
Date: Fri, 23 Feb 2001 15:30:16 -0500
From: Sourav Ghosh <sourav@cs.cmu.edu>
Organization: Carnegie Mellon University
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.15-timesys-u-16Jan01 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: creation of sock 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using linux 2.2.15 kernel on redhat.
I have added some variables (pointers) on "sock" data structure.
I was initializing them to NULL in sk_alloc() function.

But it seems some sock structures are allocated for TCP bypassing this
sk_alloc() and due to this my added pointers are not initialized to NULL
all the time.

Can anyone tell me which function is being called for generating sock
for TCP connections ( I guess for a aprticular TCP packet type, not for
all, as I'm getting into this problem intermittently, esp., when I try
access some specified website from my PC) ?

Thanks
--
Sourav


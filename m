Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313761AbSDHVai>; Mon, 8 Apr 2002 17:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313762AbSDHVah>; Mon, 8 Apr 2002 17:30:37 -0400
Received: from gumby.it.wmich.edu ([141.218.23.21]:54521 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S313761AbSDHVag>; Mon, 8 Apr 2002 17:30:36 -0400
Subject: X lockup on running after a resume
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 17:30:29 -0400
Message-Id: <1018301434.485.3.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a suspend and resume from console before starting X or loading the
dri module.  after the resume completed I loaded th dri module and x and
X got up to the point where sawfish should have started and it locked
hard.  I have to assume it's dri related and I will try without dri
(since i dont play games I dont really need it anyway) and see if it
still locks up.  I haven't tried suspending and resuming while X is
already loaded.  Would be interesting to see the results of that too
though.  




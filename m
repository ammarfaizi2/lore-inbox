Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbULJEGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbULJEGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULJEGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:06:46 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:18307 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261687AbULJEGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:06:44 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <E6D51930-4A60-11D9-9C95-000A95A6FC34@comcast.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Rob Sanders <rarob@comcast.net>
Subject: SO_RCVLOWAT option to socket()
Date: Thu, 9 Dec 2004 23:06:43 -0500
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey y'all,
    Can anyone point me to a resource for why SO_RCVLOWAT is hardcoded 
to 1 in linux?
If you are using select or poll with timeouts it would be less costly 
to have the kernel tell you
when all of the data you reqested (via SO_RCVLOWAT) is ready to be read 
instead of putting
your select/poll followed by read inside a loop to handle any partial 
data deliveries.  I've got some
code that uses SO_RCVLOWAT running under OS X, and it should run under 
Tru64, but doesn't
do what I want under Linux.  The socket man page indicates that 
SO_RCVLOWAT is hardcoded to 1.
   Please respond to me offline if possible, I don't have the time or 
resources right now to handle the
full subscription to this mailing list.  Thank you.

						Rob

						rarob
						at
						comcast
						dot
						net


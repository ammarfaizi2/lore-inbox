Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTIYNL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbTIYNL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:11:57 -0400
Received: from [170.180.5.203] ([170.180.5.203]:43783 "EHLO
	e151000n0.edmonson.k12.ky.us") by vger.kernel.org with ESMTP
	id S261151AbTIYNL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:11:56 -0400
Message-ID: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA86E@E151000N0>
From: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Date: Thu, 25 Sep 2003 08:08:16 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have hit an odd limit, that I didn't think existed.  I have a 250G
WD IDE hard drive that I have just installed.  Since I couldn't put a Ext3
filesystem on it (mount wouldn't recognize it) I decided to put a ReiserFS
filesystem on it.  Since I have done that I have added 128G of data to the
drive.  Now when I attempt to copy more data to it I get an error that there
is no more space on the drive.

I can touch a 0 byte file and delete it, but as soon as I attempt to move
anything over there with any size it errors out.  df shows me as having 112G
free on that drive so I am a little confused as to what is giving me this
error.  Is it the kernel that is not letting me write to the rest of the
drive or reiserfs or something completely different?  Any help would be
welcome.  Thanks.
 
Brent Norris
Assistant DTC, Edmonson County Schools

Ps. Please CC me on replies.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262456AbRENUAM>; Mon, 14 May 2001 16:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262455AbRENUAC>; Mon, 14 May 2001 16:00:02 -0400
Received: from [194.213.32.137] ([194.213.32.137]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S262456AbRENT7r>;
	Mon, 14 May 2001 15:59:47 -0400
Message-ID: <20010513235231.A2075@bug.ucw.cz>
Date: Sun, 13 May 2001 23:52:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: alan@redhat.com
Subject: put_user_x
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It seems to me that macro __put_user_x is defined in
asm-i386/uaccess.h and never used. It is therefore totally
unneccessary, right? [I just commented it out and recompiled; yes, it
is unneccessary]. So lib/putuser.S can disappear, too. 

Seems to me like uaccess.h could stand some cleaning...
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

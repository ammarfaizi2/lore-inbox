Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbRETQZY>; Sun, 20 May 2001 12:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262077AbRETQZO>; Sun, 20 May 2001 12:25:14 -0400
Received: from admin.csn.ul.ie ([136.201.105.1]:48390 "HELO admin.csn.ul.ie")
	by vger.kernel.org with SMTP id <S262076AbRETQY4>;
	Sun, 20 May 2001 12:24:56 -0400
Date: Sun, 20 May 2001 17:24:48 +0100 (IST)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: <airlied@skynet>
To: <linux-vax@mithra.physics.montana.edu>, <linux-kernel@vger.kernel.org>
Subject: start_thread question...
Message-ID: <Pine.LNX.4.32.0105201717100.29656-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm implementing start_thread for the VAX port and am wondering does
start_thread have to return to load_elf_binary? I'm working on the init
thread and what is happening is it is returning the whole way back to the
execve caller .. which I know shouldn't happen.....

so I suppose what I'm looking for is the point where the user space code
gets control... is it when the registers are set in the start_thread? if
so how does start_thread return....

On the VAX we have to call a return from interrupt to get to user space
and I'm trying to figure out where this should happen...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person



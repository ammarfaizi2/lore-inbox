Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbRGPQqF>; Mon, 16 Jul 2001 12:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265463AbRGPQpp>; Mon, 16 Jul 2001 12:45:45 -0400
Received: from web13903.mail.yahoo.com ([216.136.175.29]:16901 "HELO
	web13903.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265443AbRGPQpo>; Mon, 16 Jul 2001 12:45:44 -0400
Message-ID: <20010716164546.55938.qmail@web13903.mail.yahoo.com>
Date: Mon, 16 Jul 2001 09:45:46 -0700 (PDT)
From: <samandbuffy@yahoo.com>
Subject: send_sig_info help?
To: "Victoria W." <wicki@terror.de>, linux-kernel@vger.kernel.org
Cc: volker@erste.de
In-Reply-To: <Pine.LNX.4.10.10107161814140.3877-100000@csb.terror.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guys,

This is my first attempt at writing at the kernel
level. I'm working on a device driver, and usually in
userspace, I use Kill() to send a signal to a PID I
know of.

At the kernel level, I don't know of any kill()
equivalents (are there any?), except send_sig_info().

Send_sig_info(int, struct siginfo *, struct
tasktstruct *)

I know the int is the PID from "Understanding the
Linux Kernel -Oreilly". 

The problem I'm experiencing is that I'm not sure how
to find the pointer to taskstruct.  From what I"ve
read, the pointer to taskstruct is a pointer to the
target process.  How do I find the pointer to the
taskstruct of that task I want to send a signal to, if
I only know its PID?

Thanks, any help would be greatly appreciated.

Sam


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRBDQZA>; Sun, 4 Feb 2001 11:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131967AbRBDQYu>; Sun, 4 Feb 2001 11:24:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8172 "EHLO
	VL-MS-MR003.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S129436AbRBDQYi>; Sun, 4 Feb 2001 11:24:38 -0500
From: Mathieu Dube <mathieu_dube@videotron.ca>
Reply-To: mathieu_dube@videotron.ca
Organization: Mondo-Live
To: linux-kernel@vger.kernel.org
Subject: Re: accept
Date: Sun, 4 Feb 2001 11:40:55 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <200102040044.f140i7a473095@saturn.cs.uml.edu>
In-Reply-To: <200102040044.f140i7a473095@saturn.cs.uml.edu>
Cc: acahalan@cs.uml.edu
MIME-Version: 1.0
Message-Id: <01020411423601.00110@grndctrl>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Feb 2001, you wrote:
> > What does it typically mean when accept returns 0
> > and that the perror outputs "Interupted system call"??
> 
> During the call, your process received a signal.
> Most system calls are affected in this way, so that
> you may break out of what you are doing by sending
> a signal to yourself with alarm().
> 
> It sucks too, since you have to wrap nearly every
> system call in a while loop. You can avoid some of
> the trouble with careful use of sigaction() to make
> the OS restart system calls in some conditions.
Could it be the SIG32 signal that pthreads use ??
-- 
Mathieu Dube
Mondo-Live
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

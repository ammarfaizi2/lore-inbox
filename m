Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131892AbRBDQWu>; Sun, 4 Feb 2001 11:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbRBDQWa>; Sun, 4 Feb 2001 11:22:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:735 "EHLO
	VL-MS-MR003.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S131892AbRBDQWV>; Sun, 4 Feb 2001 11:22:21 -0500
From: Mathieu Dube <mathieu_dube@videotron.ca>
Reply-To: mathieu_dube@videotron.ca
Organization: Mondo-Live
To: linux-kernel@vger.kernel.org
Subject: RE: accept
Date: Sun, 4 Feb 2001 11:37:43 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKGEICNHAA.davids@webmaster.com>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKGEICNHAA.davids@webmaster.com>
Cc: davids@webmaster.com
MIME-Version: 1.0
Message-Id: <01020411401700.00110@grndctrl>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, but fd 0 cant be a valid socket since its the stdin

I posted that on this mailing list coz I thought that this might be a scaling
problem since it happens when theres already several clients connected to the
server

On Sun, 04 Feb 2001, David Schwartz wrote:
> > What does it typically mean when accept returns 0
> > and that the perror outputs "Interupted system call"??
> 
> 	Since 'accept' returning zero is not an error, the results of 'perror' are
> meaningless. Please read the manual page for 'accept' and notice that it
> says, "The call returns -1 on error". Continue reading to understand what a
> return value of zero means. Remember that zero is a non-negative integer.
> 
> 	DS
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-- 
Mathieu Dube
Mondo-Live
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

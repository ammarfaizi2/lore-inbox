Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262737AbRE0Dox>; Sat, 26 May 2001 23:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262739AbRE0Don>; Sat, 26 May 2001 23:44:43 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:41477 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262738AbRE0Doh>;
	Sat, 26 May 2001 23:44:37 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rene <kaos@intet.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 + ReiserFS + SMP + umount = oops 
In-Reply-To: Your message of "Sun, 27 May 2001 05:10:30 +0200."
             <Pine.LNX.4.21.0105270432020.13333-100000@virkelig.intet> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 27 May 2001 13:44:31 +1000
Message-ID: <30469.990935071@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2001 05:10:30 +0200 (CEST), 
Rene <kaos@intet.dk> wrote:
>Problem #2
>Certain keystrokes like ctrl+c does not work when logged in from the
>console

Are you using /dev/console or /dev/tty for the console session?
/dev/console does not support control-C, use /dev/tty for a VGA
session, /dev/ttyS<n> for a serial line.


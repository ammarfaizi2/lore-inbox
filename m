Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280214AbRJaOJ0>; Wed, 31 Oct 2001 09:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280228AbRJaOJQ>; Wed, 31 Oct 2001 09:09:16 -0500
Received: from archimede.mat.ulaval.ca ([132.203.18.50]:55807 "EHLO
	archimede.mat.ulaval.ca") by vger.kernel.org with ESMTP
	id <S280227AbRJaOIz>; Wed, 31 Oct 2001 09:08:55 -0500
Message-ID: <3BE0061D.C8834AEB@mat.ulaval.ca>
Date: Wed, 31 Oct 2001 09:09:33 -0500
From: Mihai Cartoaje <mcartoaj@mat.ulaval.ca>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 memory problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I write here to report memory problems 'I have encountered with the
later 2.2 series of kernels.

I once ran many versions of gvim without editing any file and
discovered that each subsequent launching took as much memory as the
first: around 1.2-1.6MB, IIRC. Whatever happened to shared memory?

Then this week with 2.2.19, I was in X Windows, and launched
programs many times, and then quit X Windows entirely with Ctrl-Alt
Backspace. I then did a ps -aux to make sure no process remained in
memory other than is normal at start-up. Then I ran free and it
reported 15MB of swap memory was still being used. I have a 16MB
machine and a minimal install which sometimes reports less than
1.5MB used at start-up -- RAM, that is, not swap. I think this is a
problem with 2.2 memory handling.

Mihai


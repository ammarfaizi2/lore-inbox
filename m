Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264520AbRFJLxr>; Sun, 10 Jun 2001 07:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264522AbRFJLxi>; Sun, 10 Jun 2001 07:53:38 -0400
Received: from as73.astro.ch ([192.53.104.1]:58120 "EHLO as73.astro.ch")
	by vger.kernel.org with ESMTP id <S264520AbRFJLw5>;
	Sun, 10 Jun 2001 07:52:57 -0400
Message-ID: <3B235F96.E161B138@astro.ch>
Date: Sun, 10 Jun 2001 13:52:54 +0200
From: Alois Treindl <alois@astro.ch>
Organization: Astrodienst AG   Zollikon/Zurich Switzerland
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops with kernel 2.4.5 on heavy disk traffic - reproduce
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have reported before a kernel oops.

I now oberserved the same oops, with the same stack trace,
and a Dell Poweredge 1550 with dual CPU, 1 gb RAM, only
one disk and with little disk usage (most file activity via
NFS, where this system is a client).

The kernel is identical to the one reported before,
and the stack trace is identical too.

The oops occurred with the process 'top'

I have not yet found a way to reproduce the crash in a systematic
way, I am running the kernel now on 4 different machines
under heavy load, and will try to reproduce.

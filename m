Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277006AbRJUXOA>; Sun, 21 Oct 2001 19:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277119AbRJUXNu>; Sun, 21 Oct 2001 19:13:50 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:38673 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S277006AbRJUXNd>; Sun, 21 Oct 2001 19:13:33 -0400
Message-ID: <3BD356BB.8FB3700D@eisenstein.dk>
Date: Mon, 22 Oct 2001 01:14:04 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/sys/kernel/tainted does not seem to work as intended
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have not investigated this very closely, but it seems to me that
/proc/sys/kernel/tainted does not work as intended. 
I use the nVidia binary-only drivers with my Geforce3 graphics card and
if I boot up in runlevel 3 (multi user, no X - on a Slackware 8 box) I
check that I have no modules loaded and at this point
/proc/sys/kernel/tainted is 0. Then I switch to runlevel 4 (multiuser,
with X) and the nVidia drivers load as X is started, I check
/proc/sys/kernel/tainted and find that it is still 0. Since the nVidia
drivers are binary only and not GPL shouldn't /proc/sys/kernel/tainted
be 1 (or at least != 0) ???

I'm currently running 2.4.13-pre6 + Robert Love's preempt patch.

-- 
Best regards,
Jesper Juhl
juhl@eisenstein.dk

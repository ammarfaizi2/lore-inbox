Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSK0COe>; Tue, 26 Nov 2002 21:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbSK0COe>; Tue, 26 Nov 2002 21:14:34 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:11517 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S264610AbSK0COd>;
	Tue, 26 Nov 2002 21:14:33 -0500
Date: Wed, 27 Nov 2002 03:21:49 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Thread accounting
Message-ID: <20021127022149.GA2757@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi al...

Since a discussion time ago, I know that accounting for threads is
broken in linux: getrusage does not give any info on children.
So I decided to do it by hand in my userspace app: each thread
tries to accout for itself, and parent sums up. But it looks like
getrusage called from a thread still gives the useless info about
the parent !!! Is this correct ? Any way to get accounting for a
thread itself, from the thread itself ?

(everytime I said thread, I meant _POSIX_ tread)

I am interested mainly in cpu (user/sys) accounting...

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc4-jam0 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277798AbRJIQAA>; Tue, 9 Oct 2001 12:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277802AbRJIP7v>; Tue, 9 Oct 2001 11:59:51 -0400
Received: from [217.6.75.131] ([217.6.75.131]:62878 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S277798AbRJIP7j>; Tue, 9 Oct 2001 11:59:39 -0400
Message-ID: <3BC32117.52E68787@internetwork-ag.de>
Date: Tue, 09 Oct 2001 18:08:55 +0200
From: Till Immanuel Patzschke <tip@internetwork-ag.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Q] cannot fork w/ 1000s of procs (but still mem avail.)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

hopefully a simple question to answer: I get "cannot fork" messages on my
machine running some 20000 processes and threads (1 master proc, 3 threads),
where each (master) process opens a socket and does IP traffic over it.
Although there is plenty of memory left (4GB box, 2GB used, 0 swap), I get
"cannot fork - out of memory" when trying to increase the number of procs. (If
none of the procs does IP, I can start more [of course?!].)
Anything I can do to increase the number of active processes using IP? Any
kernel paramter, limit, sizing?

Many thanks for the help in advance!

Immanuel


--
Till Immanuel Patzschke                 mailto: tip@internetwork-ag.de
interNetwork AG                         Phone:  +49-(0)611-1731-121
Bierstadter Str. 7                      Fax:    +49-(0)611-1731-31
D-65189 Wiesbaden                       Web:    http://www.internetwork-ag.de




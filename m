Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbTDBDvL>; Tue, 1 Apr 2003 22:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbTDBDvL>; Tue, 1 Apr 2003 22:51:11 -0500
Received: from mail.internetwork-ag.de ([217.6.75.131]:40375 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S261459AbTDBDvJ>; Tue, 1 Apr 2003 22:51:09 -0500
Message-ID: <3E8A60B5.E4308534@inw.de>
Date: Tue, 01 Apr 2003 20:01:57 -0800
From: Till Immanuel Patzschke <tip@inw.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [Q] cache/buffers growing constantly (2.4.20aa1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

I am constantly running a process creating child processes, running them for a
while, then terminating, restarting and so on...
The process restarted over and over again is the same (same executable) the
launching process doesn't stop.
Running this for a while (or increasing the number of "launchers" but keeping
the launched process the same all the time lets the buffers/cache constantly
grow up to the point where all memory is taken and the machine starts
swapping...

Q:Is there any way to limit the cache/buffe usage? And, if yes, how?

Thanks for the help,

Immanuel


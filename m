Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbTDGDAI (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbTDGDAI (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:00:08 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:30212 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S263208AbTDGDAH convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:00:07 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: Sockets and open()
Date: Mon, 7 Apr 2003 05:11:39 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304070511.39715.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone!
This is an issue that I can hardly believe that I haven't found any references 
for outside of here; it should be fundemental enough. I have searched far and 
wide, without being able to find anything at all. If you know of any 
references, please point me to them, so that I know where they have been 
hiding from me all this time.
Anyway, here it comes: How comes you can't use an ordinary open() call to 
connect to a UNIX domain socket? Although I haven't been able to afford the 
POSIX standard, that would seem like the natural behaviour to me. If memory 
serves me, the manpage for open on OpenBSD even suggests such a behaviour 
(although it is "currently not supported"), right? Nontheless, it apparently 
returns ENXIO under Linux. Is this _really_ the correct behaviour? It seems 
so strange to me, although I can't believe that it hasn't been implemented 
because it's too hard or something like that.
It would be so immensely practical to be able to open() UNIX sockets. Is it 
some kind of security consideration that I fail to see?

Thank you in advance,
Fredrik Tolf


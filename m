Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbUBBQwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbUBBQwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:52:43 -0500
Received: from LLMAIL.LL.MIT.EDU ([129.55.12.40]:50856 "EHLO ll.mit.edu")
	by vger.kernel.org with ESMTP id S265728AbUBBQwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:52:42 -0500
Date: Mon, 2 Feb 2004 11:52:24 -0500
From: george young <gry@ll.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: /proc/config.z disappeared in 2.4.24
Message-Id: <20040202115224.64063795.gry@ll.mit.edu>
Reply-To: gry@ll.mit.edu
Organization: MIT Lincoln Laboratory
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[SuSE x86 linux 8.2, 2.4.24 kernel building]
 
I've been upgrading from 2.4.20 (SuSE) to a fresh generic kernel from
ftp.kernel.org: 2.4.24.  In previous builds there
was a very handy virtual file /proc/config.z that allowed me to find
out exactly how the currently running kernel was configured. I could then do 

  cd /usr/src
  tar xvfz /tmp/linux-2.4.24.tz
  cd linux-2.4.24
  zcat /proc/config.z >.config
  make oldconfig  -- hit return a few dozen times
  make menuconfig -- fix a few things
  make dep && make bzImage && make modules && make modules_install
 
The /proc/config.z file seems to have disappeared! Is there some
config parameter that enables this? Or has it gone away between 2.4.20
and 2.4.24?

-- George Young
[Please cc response to gry@ll.mit.edu, I do not subscribe.  I'll also 
 watch the archives, of course]
-- 
"Are the gods not just?"  "Oh no, child.
What would become of us if they were?" (CSL)

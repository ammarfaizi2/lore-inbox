Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263348AbUEBXMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbUEBXMb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 19:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUEBXMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 19:12:30 -0400
Received: from box.punkt.pl ([217.8.180.66]:48132 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S263348AbUEBXM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 19:12:29 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.5.1
Date: Mon, 3 May 2004 01:11:49 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200405030111.49802.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- network headers got fixed - most notably removed most common collisions 
between glibc and llh (I hate making hacks, but don't have much choice - 
glibc's network headers lack functionality); iproute2 and iputils should 
build with just small patches (which can be found at the above url) and 
including linux/{in*,if*} in general should be quite safe now
- various fixes all over the place (eg. strace should build on x86-64)

Enjoy.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUEWTie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUEWTie (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbUEWTie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 15:38:34 -0400
Received: from box.punkt.pl ([217.8.180.66]:16901 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S263460AbUEWTib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 15:38:31 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.5.2
Date: Sun, 23 May 2004 21:37:27 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200405232137.27555.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- a couple more macros for big endian machines in byteorder/swab.h (eg. hdparm 
on big endian machines should build)
- missing include in linux/aio_abi.h added (don't remember what didn't build 
because of this)
- removed a conflict between linux/if.h and glibc headers


I should be releasing 2.6.6.0 now, but I do not have enough time till the end 
of May, and the last bug in the above list proved to be a little too popular 
(at least that's what the number of bug reports would suggest). Since I've 
accidentally introduced it myself in the previous release, I can't force all 
those people to patch the thing by hand because of my mistakes :)


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbRE0UBp>; Sun, 27 May 2001 16:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbRE0UBf>; Sun, 27 May 2001 16:01:35 -0400
Received: from mail-out.chello.nl ([213.46.240.7]:56611 "EHLO
	amsmta01-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S262099AbRE0UBV>; Sun, 27 May 2001 16:01:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ben Twijnstra <bentw@chello.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac1 won't boot with 4GB bigmem option
Date: Sun, 27 May 2001 22:01:02 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01052722010200.01106@beastie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I compiled and booted the 2.4.5-ac1 kernel with the CONFIG_HIGHMEM4G=y option 
and got an oops in __alloc_pages() (called by alloc_bounce() called by 
schedule()). Everything works fine if I turn the 4GB mode off.

Machine is a Dell Precision with 2 Xeons and 2GB of RAM.

2.4.5 works fine with the 4GB. Any idea what changed between the two?

Grtz,



Ben

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSDAIK4>; Mon, 1 Apr 2002 03:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSDAIKg>; Mon, 1 Apr 2002 03:10:36 -0500
Received: from ns2.wticorp.com ([209.185.218.3]:24069 "HELO
	exchange.wticorp.com") by vger.kernel.org with SMTP
	id <S310190AbSDAIK2>; Mon, 1 Apr 2002 03:10:28 -0500
Message-ID: <3CA81600.7827A9FD@wticorp.com>
Date: Mon, 01 Apr 2002 00:10:40 -0800
From: Dennis Vadura <dvadura@wticorp.com>
Organization: Web Tools International
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19p5-reiserfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre5 ext2/3 unmount bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this has already been discussed, then just ignore me, but

I have a 2.4.19-pre5 kernel with preempt-kernel and lock-break 
patches applied.  When I unmount ext2/3 filesystems I usually 
get a hard hang.  About the only message I get is:

  kjournald[125] exited with preempt_count 1

2.4.19-pre4 with same set of patches does not have this behaviour.
I'm not convinced that its confined to ext3 as unmounts of an
ext2 /usr partition without a journal caused a hard hang as well.

-dennis


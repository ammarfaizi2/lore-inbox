Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTKJRUO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 12:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbTKJRUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 12:20:14 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:11657 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264015AbTKJRUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 12:20:10 -0500
Message-ID: <3FAFC8C6.8010709@cyberone.com.au>
Date: Tue, 11 Nov 2003 04:20:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler v18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.kerneltrap.org/~npiggin/v18/

Nothing exciting for desktop users. High end performance is now starting
to get better.

Has an (unimportant) accounting fix that shouldn't really be here, but
doesn't look like it will get in before 2.6.0.

Average of 5 kernel compiles (make -j) on a 16-way 512KB cache NUMAQ gives
         bk14  bk14-v18
real    83.5s     81.7s
user   987.6s    992.5s
sys    158.0s    142.3s

Volanomark looks much better than mainline.

More testing welcome.



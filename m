Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTKAQ1r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 11:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTKAQ1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 11:27:47 -0500
Received: from fep03.swip.net ([130.244.199.131]:9159 "EHLO fep03-svc.swip.net")
	by vger.kernel.org with ESMTP id S263056AbTKAQ1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 11:27:46 -0500
Message-ID: <3FA3DF14.7010601@yahoo.fr>
Date: Sat, 01 Nov 2003 17:28:04 +0100
From: jjluza <jjluza@yahoo.fr>
Reply-To: jjluza@yahoo.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2 StumbleUpon/1.87
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Seems to have a problem with mm patch series and gcc version
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A little problem which I haven't got when I use 2.6 without mm patch :
gcc -v :
version gcc 3.3.2 (Debian)
cat /proc/version :
Linux version 2.6.0-test9 (root@mzh) (version gcc 3.3.2 (Debian)) #1 Sat 
Nov 1 16:28:07 CET 2003
instead of :
Linux version 2.6.0-test9 (root@mzh) (gcc version 3.3.2 (Debian)) #1 Sat 
Nov 1 16:28:07 CET 2003

I don't know why "gcc" and "version" are inverse with mm patch, but it 
causes a little problem when I compile
nvidia driver. (IGNORE_CC_MISMATCH).
This problem doesn't occur without mm patch.


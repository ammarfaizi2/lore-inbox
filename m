Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTDVIfk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 04:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTDVIfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 04:35:40 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:17635 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263021AbTDVIfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 04:35:38 -0400
Message-ID: <3EA50303.30200@free.fr>
Date: Tue, 22 Apr 2003 10:53:23 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc1 : aic7xxx deadlock on boot on my machine
References: <3EA4FF4C.2030702@free.fr> <200304221036.19274.m.c.p@wolk-project.de>
In-Reply-To: <200304221036.19274.m.c.p@wolk-project.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:

> I'll _bet_ that the new well good code from Justin won't make it into 2.4 
> earlier than 2.4.22-pre1.

I do not really see why because 2.4.20 -> 2.4.21 contains already such a 
driver change. Note that I mailed alan and justin on pre4-acxx. Justin 
suggested various fixes that did not resolve the problem and then 
decided to do a code inspection. Reading the Changelog, indeed the 
locking startegy has changed compared to the rc1 version. I mailed 
arcello again on pre7 even providing kdbg backtrace.

Never mind : the report is more informative to others as I already 
patched my kernel to the last version...

Thanks for responding, and providing integrated patch sets.

Have a good day.

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr


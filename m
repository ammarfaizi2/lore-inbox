Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUFKTQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUFKTQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 15:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUFKTQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 15:16:05 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:57559 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264160AbUFKTQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 15:16:03 -0400
Message-ID: <40CA04F0.9000307@nortelnetworks.com>
Date: Fri, 11 Jun 2004 15:16:00 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>, bj0rn@blox.se
Subject: kernel/module compiler version problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.22, build with gcc 3.3.1, modutils 2.4.22.

I have an ATM driver that is shipped with a binary blob and a source code shim. 
  It compiles fine.  When I go to load it, I get the following error:

"The module you are trying to load is compiled with a gcc
version 2 compiler, while the kernel you are running is compiled with
a gcc version 3 compiler. This is known to not work."

Presumably the binary blob was compiled with gcc 2.x?  Is there any way to 
override this?  "insmod -f" doesn't seem to work.

Thanks,

Chris

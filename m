Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbTDXS2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTDXS2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:28:38 -0400
Received: from watch.techsource.com ([209.208.48.130]:21238 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263781AbTDXS2i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:28:38 -0400
Message-ID: <3EA83396.4040904@techsource.com>
Date: Thu, 24 Apr 2003 14:57:26 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Strange behavior in out-of-memory situation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using Red Hat kernel 2.4.18-26.7.x.

I ran a program which is trying to suck up all of memory.  I would like 
to kill the process, but "top", "vmstat", and "ps" all hang when I try 
to use them.  Also, pressing ctrl-c in the terminal where I can the 
program won't kill it.

To an extent, however, the system was still usable, albeit EXTREMELY 
unresponsive.  Eventually, the program dumped core, and everything 
returned to norma.

Is this a known problem?


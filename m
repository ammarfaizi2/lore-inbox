Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTEAPJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTEAPJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:09:49 -0400
Received: from main.gmane.org ([80.91.224.249]:21471 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261352AbTEAPJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:09:48 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: RH8.0 - 2.4.18-27 System gets wedged in jbd:do_get_write_access
Date: Thu, 01 May 2003 09:06:14 -0600
Message-ID: <b8rd2u$2i9$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a system that has been locking up on me pretty frequently for a 
while.  It is currently running RH 8.0 kernel 2.4.18-27, but the problem 
has been present at previous versions.  I suspect a hardware issue of 
some kind, since most of our systems are running this software, but am 
not getting any error messages.

I've installed the debug kernel, and using kdb alt-sysreq-p have 
determined that all of the tasks get hung up in 
"jbd:do_get_write_access".  Basic scheduling is still working, but 
anything that attempts to access the disk hangs.

Are there any other steps I can take to debug?  I've run basic hard disk 
read diagnostics and not found any problems, as well as memtst86.

Thank you,

  Orion Poplawski



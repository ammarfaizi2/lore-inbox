Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVGXNRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVGXNRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 09:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVGXNRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 09:17:24 -0400
Received: from listserv0.isis.unc.edu ([152.2.0.38]:13983 "EHLO smtp.unc.edu")
	by vger.kernel.org with ESMTP id S261936AbVGXNQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 09:16:28 -0400
Message-ID: <42E3946E.4010009@cs.unc.edu>
Date: Sun, 24 Jul 2005 09:15:26 -0400
From: UmaMaheswari Devi <uma@cs.unc.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel debugging
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am new to kernel hacking and am facing problems in trying to peek at the
runtime values of some kernel variables using gdb.

I am issuing the gdb command as follows:
     gdb vmlinux /proc/kcore
This displays the message
    /proc/kcore: Operation not permitted
before the (gdb) prompt is displayed.
gdb then prints a value of 0 for any valid variable that is requested.

vmlinux appears to be OK, as gdb correctly identifies undefined variables.
The problem seems to be with /proc/kcore. This file has a permission of 400. I
am using the Red Hat distribution.

Any help is appreciated. 

Thanks,
Uma.



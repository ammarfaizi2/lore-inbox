Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTEFT3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTEFT3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:29:18 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:41435 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S261161AbTEFT3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:29:07 -0400
Message-ID: <3EB80FE0.4040707@cox.net>
Date: Tue, 06 May 2003 14:41:20 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.5.69-bk1] Modprobe error with agpgart
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following with modprobe when I try to probe agpgart with the 
following lines in my modprobe.conf.

Entries in /etc/modprobe.conf:
alias char-major-10-175 agpgart
options agpgart agp_try_unsupported=1

Error in dmesg:
agpgart: Unknown parameter `agp_try_unsupported'

Is this a problem in modprobe or in the agpgart driver?

Thanks,
David


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbVLKF3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbVLKF3s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 00:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbVLKF3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 00:29:47 -0500
Received: from tibor.swiftdsl.com.au ([202.154.92.226]:8149 "EHLO
	tibor.swiftdsl.com.au") by vger.kernel.org with ESMTP
	id S1161088AbVLKF3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 00:29:47 -0500
Message-ID: <439BB93F.9040406@cs.curtin.edu.au>
Date: Sun, 11 Dec 2005 13:29:35 +0800
From: Serge de Souza <serge@cs.curtin.edu.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re:2.6.15-rc5 spits oodles of hw csum failures
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
 >Hi,

 >Just booted -rc5 on another one of my boxes, and I get literally tons of
 >these everytime there's some network activity:

 >printk: 300 messages suppressed.
 > <NULL>: hw csum failure.

<snip>

 > The box is using the sk98lin driver.


Please check

http://bugzilla.kernel.org/show_bug.cgi?id=5707

For a patch.

I could not find the patch in Linus's tree, it probably should be there 
for 2.6.1.

Serge

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbUJ0S3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbUJ0S3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbUJ0SXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:23:36 -0400
Received: from [129.105.5.125] ([129.105.5.125]:5114 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S262613AbUJ0STY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:19:24 -0400
Message-ID: <417FE703.3070608@ece.northwestern.edu>
Date: Wed, 27 Oct 2004 13:20:51 -0500
From: Lei Yang <lya755@ece.northwestern.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: loopback on block device
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a question for loopback device. As far as I understand,  the 
loopback device is used to mount files as if they were block devices.

Then Why I could do "losetup -e XOR /dev/loop0 /dev/ram0" ? Notice that 
ram0 is not mounted anywhere and does not have a filesystem on it. I've 
tried that command and there seems to be no error. I got confused and 
looked into loop.c, it seems to me that a loopback device should be 
associated with a "backing file", why would it work on a block device 
anyway?

I'd appreciate your comments greatly!

TIA,
Lei


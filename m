Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVHSIH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVHSIH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 04:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVHSIH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 04:07:56 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:6796 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932168AbVHSIHz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 04:07:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g2+qKekru1WjKZj7GlwsDAK4x5wp178ijy256/6ATP7QCd/pKHs+r3gNjDxaITtsJf2EVjVWajzYpLmBKIZvXb4Wx6yxO4V1iQGwkpm/yCqeyzPYRHYpJYTZdU6UdApU2T7Vec5C2mSBCTMgwW88tizUhxwROiYdQm0VOLgAcxc=
Message-ID: <605adbb050819010770dcfaad@mail.gmail.com>
Date: Fri, 19 Aug 2005 16:07:55 +0800
From: gnome boxer <gnome.boxer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Reboot from linux,it will hang after the system POST
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use fedora core 4,when I reboot from linux(not from windows or
BIOS),it will hang after the system POST

This only happens in reboot from linux kernel within
2.6.10-2.6.13-rc4(not from BIOS or windows).when I use grub to handle
boot ,the grub will hang after the system POST,must reboot again from
BIOS to boot correct in the grub menu.


It only happened *reboot* from linux,if I directly cold boot
everything is ok,or if I reboot from windows it 's booted ok also


I tested the older kernel version from 2.6.13-rc4 to 2.6.8 .I found
the 2.6.8 and the 2.6.9 worked well without above
reboot_from_linux_with_hang_after_POST,and the 2.6.10-2.6.13-rc4 were
all have


I haven't subscribe to the LKML only for this one bug,just sendmail to me,please

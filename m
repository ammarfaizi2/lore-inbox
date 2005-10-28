Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbVJ1MoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbVJ1MoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 08:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVJ1MoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 08:44:11 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:4727 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965224AbVJ1MoJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 08:44:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oCcKxvdmtdK6I/2Z5Ep/3BRJL980zkKROFygVB1z/VhNDTxGQ/cX2QuDnErjCrqUkll7WEOed7KNi0vkq9AjWmG1EZj24D/ThJhUtxbjRahTpjVIzEJTX6wX1yL2Uz/5h4sDEpQMjksuYe5i80ks9qOJvd5KrrNuTiyuyLOWQUk=
Message-ID: <174467f50510280544g5fffdfaeq@mail.gmail.com>
Date: Fri, 28 Oct 2005 20:44:09 +0800
From: Boxer Gnome <aiko.sex@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: boot ok,but reboot hang, from 2.6.10 to 2.6.14
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when I reboot from linux(not from windows or BIOS,they all reboot ok
from them),it will hang after the system POST before enter the grub
menu list

This only happens in reboot from linux kernel within 2.6.10-2.6.14.




I tested the older kernel version from 2.6.8 to 2.6.14,and 2.4.31 .I
found the 2.6.8 and the 2.6.9,2.4.31 worked well without above
reboot_from_linux_with_hang_after_POST,and the 2.6.10-2.6.14 all have
this.

Did this belong to the special reboot_ fixed option  in the kernel?

I send to the LKML before ,but it seemed like  none fixed it

http://marc.theaimsgroup.com/?a=112443922700002&r=1&w=2

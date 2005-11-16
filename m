Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbVKPNFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVKPNFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbVKPNFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:05:37 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:25471 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030308AbVKPNFg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:05:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kfwAK4z3u3I6BV2fGGGrvmTIUnwNNTIIna6LJKUVGFd7dFjio4zq9FAnBs+Ya5EDp+IGnkX1/qJbvRPT1j5dThjoEQb04c/zsQqfwjhUHmcszoxTyfyeH57w1MLEPqQUq0LqNRrIG7xXlaxKfKK7S2W8yk5huxqVPP8BIAasV7g=
Message-ID: <3b09e8e90511160505q56b1dd48wd554a5cbdb9a247@mail.gmail.com>
Date: Wed, 16 Nov 2005 08:05:34 -0500
From: Thomas Cort <linuxgeek@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Xorg is using MAP_PRIVATE, PROT_WRITE mprotect of VM_RESERVED memory
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried running "Xorg -configure" on my alpha (EV56) with Linux kernel
2.6.15-rc1 and got the following error message: "xf86EnableIOPorts:
Failed to set IOPL for I/O". I checked the kernel log and found the
following error message:

Nov 16 06:38:49 [kernel] [4394179.238460] program Xorg is using
MAP_PRIVATE, PROT_WRITE mprotect of VM_RESERVED memory, which is
deprecated. Please report this to linux-kernel@vger.kernel.org

If you need any further information or would like me to test anything,
feel free to contact me.

Thomas Cort
linuxgeek@gmail.com

PS: Please CC all replies to me as I'm not subscribed to the list.

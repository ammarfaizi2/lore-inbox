Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVIWTJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVIWTJH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVIWTJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:09:07 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:36740 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751158AbVIWTJG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:09:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dSl0RGIxf8y+k4PKTmsbQFDGM3ESfxj6b51zLb1kjczv9CFxY+JyOLm8k9BrVRuRnTJR8Ipekkl7KpOBubM1FjQ4jW2qmQ+g2hP6nO6i4BqcTyRfXOqQALINZCYZKGL2pZlsGO31u4P5LovkLj0uQ5IMlzrY/ghqbisfzypXjnA=
Message-ID: <94e67edf050923120954346cd5@mail.gmail.com>
Date: Fri, 23 Sep 2005 15:09:04 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Placing a kernel module at a fixed address location
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a kernel module on Montavista Linux (ARM-MontavistaLinux-XIP).
My application demands me placing/running this kernel module at a
known fixed virtual/physical address. I can make this module a static
one.  For this I need the following -

***** Placing text,data, heap, stack at a known fixed address *****

May I know the possible ways of achieving this. I have tried playing
around arch/arm/vmlinux.lds linker script file. But when i try to
force the linker to place my module at a particular address, the
System.map shows me the correct address but the kernel image size is
getting very large (when add 10 words of my module, kernel image size
is getting increased by 800KB).

Any help in this is highly appreciated.

Thanks
Sreeni

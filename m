Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVKWOKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVKWOKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKWOKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:10:40 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:24363 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750802AbVKWOKk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:10:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=r1TN4HD2Gdueim+t7ZTGb5W6t9n6XV9CwCGprV7ztrpdPTxBxUzsljw8HH49h9e9uf7dWsJNEE5TkUN6NRfHEWYlVZx6Be5TsBLUVP4tPBoxJHDi8DplJO/h1mfOYtu890ZPr7jdwWGlHxxzm41pPDWB64dLMZinUUxDyMhx9vE=
Message-ID: <c216304e0511230610x2b983e59h42c10517acd59e63@mail.gmail.com>
Date: Wed, 23 Nov 2005 19:40:36 +0530
From: Ashutosh Naik <ashutosh.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Over-riding symbols in the Kernel causes Kernel Panic
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I made e1000 ( or for that matter anything) a part of the 2.6.15-rc1
kernel and booted the kernel. Next I compiled e1000 as a module (
e1000.ko ), and tried to insmod it into the kernel( which already had
e1000 a compiled as a part of the kernel). I observed that
/proc/kallsyms contained two copies of all the symbols exported by
e1000, and I also got a Kernel Panic on the way.

Is this behaviour natural and desirable ?

Regards and Thanks
-A

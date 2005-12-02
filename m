Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVLBCXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVLBCXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVLBCXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:23:51 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:18725 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964796AbVLBCXv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:23:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mQwJXlRupmO52q9XyQI5z2C6sCv+ykCI/uaspn7OSSKWPqt+Bg/OBSoglI6gZMNp+ViELQWFNqKERW0MA3CQFp/rmr/SLfS+VVMJIxHRRmcgxDWOpp/6lIILwHKm4AQkb2c+On38Xf0yH1m801mGXpQERgN0zGg+kUaadOtEPwY=
Message-ID: <2cd57c900512011823v153a6763t@mail.gmail.com>
Date: Fri, 2 Dec 2005 10:23:49 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [q] make modules_install as non-root?
Cc: torvalds@osdl.org, sam@ravnborg.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

I wrote my own installkernel so I can do `make install' as non-root
with the help of sudo. But how can we get to do `make modules_install'
as non-root with sudo as well?

The works of modules_install seem scattered over several places.  Is
it a nice idea to factor out an *installmodules* script for `make
modules_install' to invoke?

ps:
Linus recommend us to build as non-root and install as root.
I ask if we should install as non-root too.

Thanks
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/

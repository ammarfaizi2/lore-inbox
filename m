Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVECOoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVECOoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVECOo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:44:29 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:13193 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261572AbVECOnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:43:25 -0400
Date: Tue, 3 May 2005 16:43:18 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Problems with udev
Message-Id: <20050503164318.3b4ba419.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have two problems with udev:

1. When I use /dev as the root directory for udev, udev does not create
the device nodes for my serial interfaces (/dev/ttyS0 etc.) although the
necessary modules for serial device support are loaded. That prevented a
program that I use to autodetect connected mouse devices from
autodetecting a serial mouse.

2. To solve the problem mentioned above, I now use /udev as the root
directory for udev. When I now connect a USB stick to the computer, udev
does not create the device nodes for the stick (/udev/uba etc.)

Does anybody know how to solve these problems?

Kind regards
  Christoph  

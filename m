Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbUCHKNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 05:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUCHKNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 05:13:54 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:35063 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262437AbUCHKNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 05:13:52 -0500
Date: Mon, 8 Mar 2004 11:13:49 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-admin@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Redirection of STDERR
Message-Id: <20040308111349.030feea6.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In my initialization scripts for hotplug (written for bash) the
following command is used to redirect output which normally goes to
stderr to the system logger:

"exec 2> >(logger -t $0[$$])"

With kernel 2.4 this command works fine, but with kernel version 2.6.3
it leads to a system hang.

Can anybody help me to solve that problem?

Thanks in advance
  Christoph 

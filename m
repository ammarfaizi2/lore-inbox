Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVCKMRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVCKMRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVCKMRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:17:52 -0500
Received: from f6.mail.ru ([194.67.57.36]:40978 "EHLO f6.mail.ru")
	by vger.kernel.org with ESMTP id S262681AbVCKMFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:05:42 -0500
From: Serge Goodenko <s_goodenko@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Disabling fastpath code in tcp_rcv_established()
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.69.119.168]
Date: Fri, 11 Mar 2005 15:05:40 +0300
Reply-To: Serge Goodenko <s_goodenko@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1D9itg-0003aZ-00.s_goodenko-mail-ru@f6.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I tried to disable fastpath code in tcp_rcv_established() (i suppose i need this for some debugging purposes)
by commenting out corresponding lines 4110-4252 in net/ipv4/tcp_input.c (kernel ver 2.4.28)
after recompiling kernel doesn't want to transmit tcp packets properly and even segmenatation faults from time to time...
where am i wrong?

thanks,
Serge Goodenko,
MIPT, Russia

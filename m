Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUCKHXl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUCKHXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:23:41 -0500
Received: from palrel10.hp.com ([156.153.255.245]:44503 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261602AbUCKHWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:22:55 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16464.5068.454398.649614@napali.hpl.hp.com>
Date: Wed, 10 Mar 2004 23:22:52 -0800
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] fix PCI interrupt setting for ia64
In-Reply-To: <MDEEKOKJPMPMKGHIFAMAEELHDGAA.kaneshige.kenji@jp.fujitsu.com>
References: <16463.30226.948230.439549@napali.hpl.hp.com>
	<MDEEKOKJPMPMKGHIFAMAEELHDGAA.kaneshige.kenji@jp.fujitsu.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 11 Mar 2004 09:34:06 +0900, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> said:

  Kenji> Hi, I'm sorry that the report falls behind. I wanted to check
  Kenji> out by using real device driver which uses a probe_irq_on(),
  Kenji> but I don't have appropriate environment now.

  Kenji> Though I didn't check out on a real machine yet, I believe my
  Kenji> patch doesn't have any influence on probe_irq_on() because
  Kenji> current probe_irq_on() calls startup callback to unmask the
  Kenji> RTEs as you said before.

OK, I agree.

Thanks,

	--david

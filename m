Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267253AbUBSAwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbUBSAwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:52:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16056 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267253AbUBSAwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:52:18 -0500
Date: Wed, 18 Feb 2004 16:52:10 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: mingo@redhat.com, zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: sys_tux stolen @s390 in 2.6
Message-Id: <20040218165210.4dd0464e.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin -

in 2.4, syscall #222 was reserved for tux on s390, but now it is used
by sys_readahead. What do we do now?

Thanks,
-- Pete

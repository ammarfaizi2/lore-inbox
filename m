Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTJRAEq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263662AbTJRAEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:04:45 -0400
Received: from devil.servak.biz ([209.124.81.2]:53420 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S263661AbTJRAEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:04:44 -0400
Subject: 2.6.0-test8 depmod error
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1066435479.12721.1.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 17:04:40 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this during make modules_install on 2.6.0-test8:

WARNING: /lib/modules/2.6.0-test8/kernel/net/ipv6/ipv6.ko needs unknown
symbol __secpath_destroy

depmod --version == module-init-tools 0.9.15-pre1

-- 
Torrey Hoffman <thoffman@arnor.net>


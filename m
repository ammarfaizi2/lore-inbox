Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTDNRBL (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTDNRBL (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:01:11 -0400
Received: from mail.wincom.net ([209.216.129.3]:43020 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id S263570AbTDNRBK (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 13:01:10 -0400
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Mon, 14 Apr 2003 13:11:24 -0400
Subject: 2.4.21-pre7 - "make xconfig" broken
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3e9aeb5c.1e45.0@wincom.net>
X-User-Info: 129.9.163.105
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Rcpt-To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vanilla 2.4.21-pre7 "make xconfig" is broken:

./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/ide/Config.in: 46: can't handle dep_bool/dep_mbool/dep_tristate
condition
make[1]: *** [kconfig.tk] Error 1

DG

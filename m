Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWGQFUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWGQFUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 01:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWGQFUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 01:20:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:52450 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751160AbWGQFUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 01:20:00 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: False positive on sparse check of ia64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jul 2006 15:19:52 +1000
Message-ID: <14623.1153113592@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running sparse on 2.6.18-rc1 ia64.  sparse does not know about
__builtin_extract_return_addr.

  CHECK   arch/ia64/kernel/process.c
  include/linux/kallsyms.h:64:10: error: undefined identifier '__builtin_extract_return_addr'
  include/linux/kallsyms.h:63:23: error: cast from unknown type



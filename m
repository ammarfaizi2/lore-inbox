Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWGHRkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWGHRkv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWGHRkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:40:51 -0400
Received: from [212.33.165.128] ([212.33.165.128]:60174 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S964909AbWGHRkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:40:51 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-fsdevel@vger.kernel.org
Subject: [RFC] VFS: FS CoW using redirection
Date: Sat, 8 Jul 2006 20:41:54 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607082041.54489.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Copy on Write is a neat way to quickly achieve a semi-clustered system, by 
mounting any shared FS read-only and redirecting writes to some perClient 
FS.

Would this redirection be easy to implement into the VFS?

Thanks!

--
Al


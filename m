Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270766AbTGNTb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270825AbTGNTb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:31:58 -0400
Received: from verein.lst.de ([212.34.189.10]:25024 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S270766AbTGNTaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:30:21 -0400
Date: Mon, 14 Jul 2003 21:45:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Quota compilation broken in current BK
Message-ID: <20030714194500.GA13981@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, marcelo@conectiva.com.br,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -2.5 () USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

looks like Alan's quota format patch is missing some header updates..


dquot.c:77: error: elements of array `module_names' have incomplete type
dquot.c:77: error: `INIT_QUOTA_MODULE_NAMES' undeclared here (not in a function)
dquot.c: In function `find_quota_format':
dquot.c:108: error: invalid use of undefined type `struct quota_module_name'
dquot.c:108: error: invalid use of undefined type `struct quota_module_name'
dquot.c:109: error: invalid use of undefined type `struct quota_module_name'
dquot.c:109: error: invalid use of undefined type `struct quota_module_name'

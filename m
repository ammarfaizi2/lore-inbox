Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTLLEtu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 23:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTLLEtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 23:49:50 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:6098 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S264477AbTLLEtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 23:49:49 -0500
Date: Fri, 12 Dec 2003 04:49:46 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: sparse/TSCT BitKeeper repository
Message-ID: <Pine.LNX.4.58.0312120414360.8280@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where is the sparse BK repository that used to be
bk://kernel.bkbits.net/torvalds/sparse ?
It seems there is an older version at bk://linux-dj.bkbits.net/sparse

Also in the subject, I got lots of "attribute 'alias': unknown attribute"
warnings in the kernel source in lines with module_init(), module_exit()
and others. A simple fix might be

	if (match_string_ident(attribute, "alias"))
		return NULL;

near the end of handle_attribute() in parse.c


Regards,
	Rui Saraiva

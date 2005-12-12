Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVLLSCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVLLSCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVLLSCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:02:44 -0500
Received: from hera.kernel.org ([140.211.167.34]:57229 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932095AbVLLSCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:02:43 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 2/9] isdn4linux: Siemens Gigaset drivers - common module
Date: Mon, 12 Dec 2005 10:02:38 -0800
Organization: OSDL
Message-ID: <20051212100238.365e75ea@unknown-222.office.pdx.osdl.net>
References: <gigaset307x.2005.12.11.001.0@hjlipp.my-fqdn.de>
	<gigaset307x.2005.12.11.001.1@hjlipp.my-fqdn.de>
	<gigaset307x.2005.12.11.001.2@hjlipp.my-fqdn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1134410560 15375 10.8.0.222 (12 Dec 2005 18:02:40 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 12 Dec 2005 18:02:40 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since you are doing a indirect module based infrastructure.
You need to handle module refcounting of gigaset_ops.

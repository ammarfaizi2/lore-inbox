Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUKHKEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUKHKEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 05:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUKHKEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 05:04:54 -0500
Received: from canuck.infradead.org ([205.233.218.70]:41993 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261475AbUKHKEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 05:04:53 -0500
Subject: Re: [PATCH] Fix O_SYNC speedup for generic_file_write_nolock
From: Arjan van de Ven <arjan@infradead.org>
To: suparna@in.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20041108100738.GA4003@in.ibm.com>
References: <20041108100738.GA4003@in.ibm.com>
Content-Type: text/plain
Message-Id: <1099908278.3577.2.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 08 Nov 2004 11:04:38 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +EXPORT_SYMBOL(sync_page_range_nolock);


why adding this export? nothing appears to be using it (AIO isn't a module after all)


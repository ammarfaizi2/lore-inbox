Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbUKHQ5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUKHQ5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUKHQxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:53:41 -0500
Received: from canuck.infradead.org ([205.233.218.70]:20740 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261901AbUKHPbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:31:38 -0500
Subject: Re: [PATCH] Fix O_SYNC speedup for generic_file_write_nolock
From: Arjan van de Ven <arjan@infradead.org>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: suparna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20041108152043.GR12500@ca-server1.us.oracle.com>
References: <20041108100738.GA4003@in.ibm.com>
	 <1099908278.3577.2.camel@laptop.fenrus.org>
	 <20041108115353.GA4068@in.ibm.com>
	 <1099915544.3577.9.camel@laptop.fenrus.org>
	 <20041108152043.GR12500@ca-server1.us.oracle.com>
Content-Type: text/plain
Message-Id: <1099927877.3577.15.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 08 Nov 2004 16:31:17 +0100
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

On Mon, 2004-11-08 at 07:20 -0800, Joel Becker wrote:
> 	OCFS2 uses generic_file_write_nolock(), and as such we might
> want to look into this problem and the sync_page_range_nolock() fix.

are you going to submit ocfs2 soon for inclusion ?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVCBVda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVCBVda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVCBVbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:31:12 -0500
Received: from fire.osdl.org ([65.172.181.4]:1199 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262463AbVCBV3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:29:22 -0500
Date: Wed, 2 Mar 2005 13:29:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: muthian_s@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: ext3 journal commit performance
Message-Id: <20050302132901.45f5b9ee.akpm@osdl.org>
In-Reply-To: <20050302095852.3d4da20b.akpm@osdl.org>
References: <20050302165814.70651.qmail@web53704.mail.yahoo.com>
	<20050302095852.3d4da20b.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  However, what you are proposing is, I think,
> 
>  	1) write the data
>  	2) write the journal
>  	3) wait on the data write
>  	4) wait on the journal write

	5) write the commit block
	6) wait on the commit block


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVIPU4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVIPU4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVIPU4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:56:14 -0400
Received: from kanga.kvack.org ([66.96.29.28]:9919 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750853AbVIPU4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:56:13 -0400
Date: Fri, 16 Sep 2005 16:55:33 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Ram <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@ftp.linux.org.uk, miklos@szeredi.hu, mike@waychison.com,
       bfields@fieldses.org, serue@us.ibm.com
Subject: Re: [RFC PATCH 1/10] vfs: Lindentified namespace.c
Message-ID: <20050916205533.GB20966@kvack.org>
References: <20050916182619.GA28428@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916182619.GA28428@RAM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2005 at 11:26:19AM -0700, Ram wrote:
> -static void *m_start(struct seq_file *m, loff_t *pos)
> +static void *m_start(struct seq_file *m, loff_t * pos)

This is wrong, probably an lindent bug.

		-ben

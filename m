Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUCQUb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCQUb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:31:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:9404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261998AbUCQUb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:31:26 -0500
Date: Wed, 17 Mar 2004 12:33:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: daniel@osdl.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: 2.6.4-mm2
Message-Id: <20040317123324.46411197.akpm@osdl.org>
In-Reply-To: <1079554288.4183.1938.camel@watt.suse.com>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	<1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	<1079474312.4186.927.camel@watt.suse.com>
	<20040316152106.22053934.akpm@osdl.org>
	<20040316152843.667a623d.akpm@osdl.org>
	<20040316153900.1e845ba2.akpm@osdl.org>
	<1079485055.4181.1115.camel@watt.suse.com>
	<1079487710.3100.22.camel@ibm-c.pdx.osdl.net>
	<20040316180043.441e8150.akpm@osdl.org>
	<1079554288.4183.1938.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> [ data not getting flushed ]
> 
> Ummm, this might help:

Pedant.

Now I have to work out why I saw longer runtimes with O_SYNC.  Metadata
I guess...

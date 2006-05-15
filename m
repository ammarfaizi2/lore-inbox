Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWEOWkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWEOWkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbWEOWkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:40:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20700 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965100AbWEOWkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:40:08 -0400
Date: Mon, 15 May 2006 15:42:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nathan Scott <nathans@sgi.com>
Cc: pbadari@us.ibm.com, hch@lst.de, bcrl@kvack.org, cel@citi.umich.edu,
       zach.brown@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Streamline generic_file_* interfaces and filemap
 cleanups
Message-Id: <20060515154240.49534bd8.akpm@osdl.org>
In-Reply-To: <20060516082804.F5598@wobbly.melbourne.sgi.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	<1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	<1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
	<1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
	<1147728206.6181.7.camel@dyn9047017100.beaverton.ibm.com>
	<20060516082804.F5598@wobbly.melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>
> Any chance that could be renamed to something thats a bit clearer,
> maybe generic_file_non_aio_read and generic_file_non_aio_write?

I guess that logically, we should avoid the double-negative and use
generic_file_sio_*.

I dunno if we want to be that logical though ;)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbUJ2Uwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUJ2Uwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUJ2UvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:51:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:7848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263551AbUJ2Ugd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:36:33 -0400
Date: Fri, 29 Oct 2004 13:34:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes to fs/buffer.c?
Message-Id: <20041029133420.76a758b3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0410291516580.19494@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0410291516580.19494@hermes-1.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> Is it ok to export 
>  create_buffers() and to make __set_page_buffers() static inline and move 
>  it to include/linux/buffer.h?

ho, hum - if you must ;)

I'd be inclined to rename it to attach_page_buffers() or something though -
create_buffers() is a bit generic-sounding.


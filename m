Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUFJWZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUFJWZc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUFJWZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:25:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:43191 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263154AbUFJWZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:25:31 -0400
Date: Thu, 10 Jun 2004 15:28:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Bikram Assal" <bikram.assal@wku.edu>
Cc: bwindle@fint.org, linux-kernel@vger.kernel.org
Subject: Re: ENOMEM in do_get_write_access, retrying
Message-Id: <20040610152807.4f06c3b1.akpm@osdl.org>
In-Reply-To: <web-68590618@mailadmin.wku.edu>
References: <Pine.LNX.4.58.0406101737090.959@morpheus>
	<web-68590618@mailadmin.wku.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bikram Assal" <bikram.assal@wku.edu> wrote:
>
> The kernel version installed on the server is 2.4.18-5
> 
> Would that be a problem ? Do I need to upgrade my kernel ?
> 
> Since the memory doesn't seem to be a problem apparently, what should be my next step to check the flaw.
> 
> Although this happened only once, this could lead to a possible problem.

It's just a warning.  The filesystem retries the allocation and it succeeded.  There's
nothing you need to do.

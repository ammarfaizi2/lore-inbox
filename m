Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269171AbUIYBaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269171AbUIYBaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269172AbUIYBaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:30:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:13731 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269171AbUIYBaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:30:18 -0400
Date: Fri, 24 Sep 2004 18:28:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: mlock(1)
Message-Id: <20040924182808.0554ca6a.akpm@osdl.org>
In-Reply-To: <20040924172611.Y1973@build.pdx.osdl.net>
References: <41547C16.4070301@pobox.com>
	<20040924141731.7ced31f7.akpm@osdl.org>
	<20040924172611.Y1973@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
>  Here's a simple (bit ugly) hack that does it (esp. the exec part).

Seems complicated.  IIRC it's just a matter of propagating a suitable flag
in oldmm->def_flags into the new mm in copy_mm().


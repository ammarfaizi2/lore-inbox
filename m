Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270684AbTGUSlX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270685AbTGUSlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:41:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:32920 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270684AbTGUSlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 14:41:23 -0400
Date: Mon, 21 Jul 2003 19:56:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] percpu struct members.
Message-ID: <20030721185619.GB6912@mail.jlokier.co.uk>
References: <20030716083750.6DC4A2C141@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716083750.6DC4A2C141@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> The current percpu macros do not allow __get_cpu_var(foo.val1)
> which makes building macros on top of them really difficult.

What's the problem with __get_cpu_var(foo).val1 ?

-- Jamie

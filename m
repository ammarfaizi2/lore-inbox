Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUCCA6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbUCCA6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:58:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:15059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262304AbUCCA6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:58:53 -0500
Date: Tue, 2 Mar 2004 16:59:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Art Haas" <ahaas@airmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile kernel with GCC-3.5 and without regparm
Message-Id: <20040302165928.3bdd918d.akpm@osdl.org>
In-Reply-To: <20040303002339.GA20651@artsapartment.org>
References: <20040303002339.GA20651@artsapartment.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Art Haas" <ahaas@airmail.net> wrote:
>
> I tried to build the kernel with my CVS GCC-3.5 compiler today, and had
> all sorts of failures about prototypes not matching.

-mm is where the gcc-3.5 action is.  There seems to be a bit of an arms
race going on wherein the gcc developers are trying to break the kernel
build faster than I and others can fix it.

See the fastcall-* patches.

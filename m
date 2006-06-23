Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752085AbWFWVcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbWFWVcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWFWVcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:32:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752085AbWFWVcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:32:32 -0400
Date: Fri, 23 Jun 2006 14:32:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.17-mm1
Message-Id: <20060623143205.9b8bfa96.akpm@osdl.org>
In-Reply-To: <a762e240606231339n11b8de89r37b9ff0401c50e21@mail.gmail.com>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<a762e240606231339n11b8de89r37b9ff0401c50e21@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 13:39:01 -0700
"Keith Mannthey" <kmannth@gmail.com> wrote:

> Andrew,
>   When I make mrproper to clean the kernel tree with the -mm trees (at
> least the last few releases) I end up having to remove
> /include/linux/dwarf2-defs.h myself.  This file is generated at build
> time but mrproper isn't cleaning it up.   This file is always present
> in a tree that has been built but not in the origninal tree so a diff
> of the tree picks it up.
> 
> Is this expected?
> 

No, it's not expected.  That's due to the kgdb patches.

Sam, what should we be doing here?

Thanks.

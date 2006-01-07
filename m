Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWAGGgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWAGGgy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 01:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWAGGgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 01:36:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9390 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030304AbWAGGgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 01:36:53 -0500
Date: Fri, 6 Jan 2006 22:33:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: jgarzik@pobox.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
Message-Id: <20060106223311.134d76d4.akpm@osdl.org>
In-Reply-To: <1136576160.2940.76.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
	<1136544309.2940.25.camel@laptopd505.fenrus.org>
	<43BEA970.4050704@pobox.com>
	<1136576160.2940.76.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> if optimizing for size (CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers
>  to decide what to inline and what not - instead of the kernel forcing gcc
>  to inline all the time. This requires several places that require to be 
>  inlined to be marked as such, previous patches in this series do that.

This one stomps all over more-updates-for-the-gcc-=-32-requirement.patch. 
PLease redo against 2.6.15-mm1 or next -mm?

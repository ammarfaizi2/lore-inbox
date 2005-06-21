Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVFUWkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVFUWkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVFUWj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:39:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262315AbVFUWS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:18:29 -0400
Date: Tue, 21 Jun 2005 15:18:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more signed char cleanups in scripts
Message-Id: <20050621151806.07ef0f78.akpm@osdl.org>
In-Reply-To: <1119391748l.25237l.3l@werewolf.able.es>
References: <20050619233029.45dd66b8.akpm@osdl.org>
	<1119391748l.25237l.3l@werewolf.able.es>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> This cleans the last signedness problems I have seen in scripts, at least
>  what I can see with make oldconfig, make config, make menuconfig, 
>  make gconfig and make.

Remind me: what's the point in these changes?

I see no particular problem using uchar in the kallsyms code - I often
prefer it, because you can just look at the code and not have to worry
about nasty sign-extension problems.


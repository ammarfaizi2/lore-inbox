Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268657AbUGXO7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268657AbUGXO7a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 10:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUGXO73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 10:59:29 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:53188 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S268657AbUGXO72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 10:59:28 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
Cc: Mikael Pettersson <mikpe@csd.uu.se>, jamagallon@able.es,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.27+stdarg+gcc-3.4.1 
In-reply-to: Your message of "Sat, 24 Jul 2004 09:19:04 -0400."
             <Pine.LNX.4.53.0407240915260.2402@chaos> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Jul 2004 00:59:22 +1000
Message-ID: <18199.1090681162@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jul 2004 09:19:04 -0400 (EDT), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>> >gcc -D__KERNEL__ -nostdinc -iwithprefix include
>                     ^^^^^^^_______
>
>This will prevent it from using its private copy of stdarg.h.
>
>There needs to be one in the -I<include-path>

No.  -iwithprefix include picks up the private path.  It is probably a
misconfigured gcc, but I am waiting on detailed diagnostics to be sure.


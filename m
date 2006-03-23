Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWCWJUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWCWJUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWCWJUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:20:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751397AbWCWJUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:20:43 -0500
Date: Thu, 23 Mar 2006 01:17:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix bug: flat binary loader doesn't check fd table full
Message-Id: <20060323011718.7f34a282.akpm@osdl.org>
In-Reply-To: <489ecd0c0603230115h4dd2b16fg54cfd97739a8b339@mail.gmail.com>
References: <489ecd0c0603222310j3f2b9804k30bca1adce33804d@mail.gmail.com>
	<20060322234652.10f6afee.akpm@osdl.org>
	<489ecd0c0603230115h4dd2b16fg54cfd97739a8b339@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
>   Thanks, I tested you patch. Just one thing: syscall.h is needed to call
> sys_close().

ah, yes.

>   Anyone knows how to avoid "tab to space" converting in gmail?

If I knew, I'd put it in my .signature :(

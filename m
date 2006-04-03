Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWDCJ1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWDCJ1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWDCJ1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:27:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751397AbWDCJ1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:27:50 -0400
Date: Mon, 3 Apr 2006 02:27:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: mitch@sfgoth.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc1 core_sys_select incompatible pointer types
Message-Id: <20060403022701.5a2144cc.akpm@osdl.org>
In-Reply-To: <26766.1144055892@kao2.melbourne.sgi.com>
References: <20060403020916.57c9eaec.akpm@osdl.org>
	<26766.1144055892@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
>  When did arithmetic on void pointers become acceptable?  I know that it
>  is a gcc extension but AFAIK its use is discouraged.  Or am I in the
>  wrong parallel universe again?

Yes, it's a gccism, but we actually use it rather a lot here and there. 
It's quite useful for avoiding casting.

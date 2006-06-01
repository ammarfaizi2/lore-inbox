Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWFAQ1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWFAQ1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWFAQ1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:27:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56035 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030229AbWFAQ1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:27:24 -0400
Date: Thu, 1 Jun 2006 09:30:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
Subject: Re: 2.6.17-rc5-mm2 stack unwind compile failure
Message-Id: <20060601093052.f2e3789f.akpm@osdl.org>
In-Reply-To: <447ED570.5020303@aitel.hist.no>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<447ED570.5020303@aitel.hist.no>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 13:54:24 +0200
Helge Hafting <helge.hafting@aitel.hist.no> wrote:

> 2.6.17-rc5-mm2 with the cfq hotfix:
> 
>   CC      kernel/unwind.o
> kernel/unwind.c: In function ‘unwind_add_table’:
> kernel/unwind.c:189: error: dereferencing pointer to incomplete type
> kernel/unwind.c:190: error: dereferencing pointer to incomplete type
> kernel/unwind.c:190: error: dereferencing pointer to incomplete type
> kernel/unwind.c:191: error: dereferencing pointer to incomplete type
> kernel/unwind.c:191: error: dereferencing pointer to incomplete type
> make[1]: *** [kernel/unwind.o] Error 1
> make: *** [kernel] Error 2
> 

Jan, you have a CONFIG_MODULES=n problem.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbUKRHCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbUKRHCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 02:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUKRHCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 02:02:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:18623 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262649AbUKRHBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 02:01:16 -0500
Date: Wed, 17 Nov 2004 23:01:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Altivec support for RAID-6
Message-Id: <20041117230100.515c6278.akpm@osdl.org>
In-Reply-To: <419C46C7.4080206@zytor.com>
References: <419C46C7.4080206@zytor.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:
>
>   $(obj)/raid6int1.c:   $(src)/raid6int.uc $(src)/unroll.pl FORCE

So we require that raid6int.uc propagate through the system with the x bit
set.

I wonder if it would be safer to stick a $(SHELL) in there?

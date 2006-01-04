Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWADXvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWADXvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWADXvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:51:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750755AbWADXvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:51:45 -0500
Date: Wed, 4 Jan 2006 15:53:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
Message-Id: <20060104155326.351a9c01.akpm@osdl.org>
In-Reply-To: <20060103135312.GB18060@redhat.com>
References: <20060103082609.GB11738@redhat.com>
	<43BA630F.1020805@yahoo.com.au>
	<20060103135312.GB18060@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
>  > Can you print ->flags, ->count, ->mapping, etc instead of going BUG?
> 
> I can add some instrumentation like this though, and see what turns up.

Can we get that instrumentation into the upstream kernel please?  We do
seem to be hitting rmap assertions too often for it to be dud
hardware/bodgy drivers/etc.

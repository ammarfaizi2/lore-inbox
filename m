Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWBPKrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWBPKrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 05:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWBPKrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 05:47:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750788AbWBPKrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 05:47:39 -0500
Date: Thu, 16 Feb 2006 02:46:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: ce@ruault.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
Message-Id: <20060216024625.1b5dc77b.akpm@osdl.org>
In-Reply-To: <20060216103619.GI30182@vanheusden.com>
References: <43EF8388.10202@ruault.com>
	<20060215185120.6c35eca2.akpm@osdl.org>
	<43F44978.2050809@ruault.com>
	<20060216103619.GI30182@vanheusden.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden <folkert@vanheusden.com> wrote:
>
> I noticed that altough -i says using dma, that -d tells me it really is
>  off.

Yup, `hdparm -i' tells you what the drive _can_ do, not what it's actually
doing.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWBXMva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWBXMva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWBXMva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:51:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750816AbWBXMv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:51:29 -0500
Date: Fri, 24 Feb 2006 04:50:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: dilinger@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 stack trace cleanup
Message-Id: <20060224045044.07fc5921.akpm@osdl.org>
In-Reply-To: <200602241147.03041.ak@suse.de>
References: <1140777679.5073.17.camel@localhost.localdomain>
	<200602241147.03041.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> I can offer you a deal though: if you fix VGA scrollback to have
>  at least 1000 lines by default we can change the oops formatting too.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/broken-out/vgacon-add-support-for-soft-scrollback.patch

Problem is, scrollback doesn't work after panic().  I don't know why..

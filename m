Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268232AbUJGXME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268232AbUJGXME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269917AbUJGXLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:11:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:42708 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268232AbUJGXI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:08:27 -0400
Date: Thu, 7 Oct 2004 16:12:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: opps 2.6.9-r3-mm3
Message-Id: <20041007161211.3306958f.akpm@osdl.org>
In-Reply-To: <20041007195548.GA4425@the-penguin.otak.com>
References: <20041007195548.GA4425@the-penguin.otak.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton <lawrence@the-penguin.otak.com> wrote:
>
> Hi I had repeated oops after boot-up. Looked like scheduler stuff.

cd <location of kernel tree>
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/broken-out/optimize-profile-path-slightly.patch
patch -R -p1 < optimize-profile-path-slightly.patch


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbUBXX6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUBXX5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:57:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:44525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262531AbUBXXyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:54:38 -0500
Date: Tue, 24 Feb 2004 15:56:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Dorey <mdorey@bluearc.com>
Cc: linux-kernel@vger.kernel.org, mdorey@bluearc.com
Subject: Re: init_dev accesses out-of-bounds tty index
Message-Id: <20040224155628.01ba0d05.akpm@osdl.org>
In-Reply-To: <AD4480A509455343AEFACCC231BA850FF0FE5A@ukexchange>
References: <AD4480A509455343AEFACCC231BA850FF0FE5A@ukexchange>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dorey <mdorey@bluearc.com> wrote:
>
> Unable to handle kernel paging request at virtual address 00e000b2

That's a weird address.  Could you please enable CONFIG_DEBUG_SLAB and
CONFIG_DEBUG_PAGEALLOC, see if you can make it happen again?


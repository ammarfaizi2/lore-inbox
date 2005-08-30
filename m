Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVH3XDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVH3XDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVH3XDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:03:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932266AbVH3XDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:03:15 -0400
Date: Tue, 30 Aug 2005 16:03:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Pritesh Shah <pritesh.myphotos@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GDT initialization and location question.
Message-ID: <20050830230311.GW7762@shell0.pdx.osdl.net>
References: <6967c2bf0508301351584d6f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6967c2bf0508301351584d6f10@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pritesh Shah (pritesh.myphotos@gmail.com) wrote:
> I was wondering as to where is the GDT initialized during the boot
> sequence? I will need the filename and the name of the routine that
> does this. Any help would be greatly appreciated.

Search for cpu_gdt_table (one is literal, the other is per_cpu).  You
should be able to work it out from there.

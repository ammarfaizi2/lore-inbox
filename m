Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWH1SlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWH1SlU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWH1SlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:41:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751325AbWH1SlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:41:20 -0400
Date: Mon, 28 Aug 2006 11:40:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
Message-Id: <20060828114017.0c8d29c7.akpm@osdl.org>
In-Reply-To: <200608280554_MC3-1-C993-607@compuserve.com>
References: <200608280554_MC3-1-C993-607@compuserve.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 05:50:07 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> > From: Chuck Ebbert <76306.1226@compuserve.com>
> > Subject: PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0
> 
> Also happens on 2.6.16.28 and 2.6.17.11, so not a regression.

Well it's not a post-2.6.17 regression.  But it's something which quite a few
people have been reporting in recent months.  I don't _think_ it's associated
with any consistent runtime failures, but otoh I don't think we know what
caused it.

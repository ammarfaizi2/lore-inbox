Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275125AbTHGHEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 03:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275126AbTHGHEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 03:04:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:60904 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275125AbTHGHEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 03:04:00 -0400
Date: Thu, 7 Aug 2003 00:05:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-Id: <20030807000542.5cbf0a56.akpm@osdl.org>
In-Reply-To: <28050000.1060237907@[10.10.2.4]>
References: <20030806223716.26af3255.akpm@osdl.org>
	<28050000.1060237907@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> I get lots of these .... (without 4/4 turned on)
> 
>   Badness in as_dispatch_request at drivers/block/as-iosched.c:1241

yes, it happens with aic7xxx as well.  Sorry about that.

You'll need to revert 

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm5/broken-out/as-no-trinary-states.patch

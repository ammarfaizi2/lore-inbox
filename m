Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTEZR2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTEZR2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:28:34 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:46532 "EHLO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261916AbTEZR2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:28:31 -0400
Date: Tue, 27 May 2003 02:41:41 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: Robert Creager <Robert_Creager@LogicalChaos.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with virtually no buffer usage in 2.4.21mdk kernel
Message-Id: <20030527024141.5b168415.bharada@coral.ocn.ne.jp>
In-Reply-To: <20030525081253.05d4e5f3.Robert_Creager@LogicalChaos.org>
References: <20030524223320.7c1ac413.Robert_Creager@LogicalChaos.org>
	<20030525151816.4a433953.bharada@coral.ocn.ne.jp>
	<20030525081253.05d4e5f3.Robert_Creager@LogicalChaos.org>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003 08:12:53 -0600
Robert Creager <Robert_Creager@LogicalChaos.org> wrote:

> That's why I said virtually no buffer usage (not shared memory).  I'm
> looking at the 88kb (90112).  On my other two systems, both 2.4.19 with
> 640Mb and 128Mb memory, the buffer usage is 86Mb, and 44Mb respectivly.
> 
> Other thoughts?

Ah, my apologies. As for why your buffer usage is so low, it's likely a bit
difficult to tell whether it's indicative of a problem without knowing what
patches have been applied to the Mandrake kernel. Also, I believe the buffers
value these days isn't as useful a metric as it used to be, so personally I
wouldn't worry about it too much, unless you're seeing problems with the box.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319337AbSH2UmR>; Thu, 29 Aug 2002 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319338AbSH2UmR>; Thu, 29 Aug 2002 16:42:17 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35847
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319337AbSH2UmR>; Thu, 29 Aug 2002 16:42:17 -0400
Subject: Re: [PATCH] low-latency zap_page_range()
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1030653602.939.2677.camel@phantasy>
References: <1030635100.939.2551.camel@phantasy> 
	<3D6E844C.4E756D10@zip.com.au>  <1030653602.939.2677.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 16:46:43 -0400
Message-Id: <1030654004.12110.2685.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-29 at 16:40, Robert Love wrote:

> On Thu, 2002-08-29 at 16:30, Andrew Morton wrote:
> 
> > However with your change, we'll only ever put 256 pages into the
> > mmu_gather_t.  Half of that thing's buffer is unused and the
> > invalidation rate will be doubled during teardown of large
> > address ranges.
> 
> Agreed.  Go for it.

Oh and put a comment in there explaining what you just said to me :)

	Robert Love



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUIMSZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUIMSZm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUIMSZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:25:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:6633 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268404AbUIMSZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:25:41 -0400
Subject: Re: 2.6.9-rc1-mm5 compile errors
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040913100757.2be28ab6.pj@sgi.com>
References: <1095093355.3628.152.camel@dyn318077bld.beaverton.ibm.com>
	 <20040913100757.2be28ab6.pj@sgi.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095099722.3628.154.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Sep 2004 11:22:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got it. Worked fine. 

Thanks,
Badari

On Mon, 2004-09-13 at 10:07, Paul Jackson wrote:
> For this error:
> 
>     mm/mempolicy.c: In function `get_zonemask':
>     mm/mempolicy.c:419: error: `maxnode' undeclared (first use in this function)
>     mm/mempolicy.c:419: error: (Each undeclared identifier is reported only once
>     mm/mempolicy.c:419: error: for each function it appears in.)
> 
> See my fix on posted 4 hours ago on lkml:
> 
>   Subject: [PATCH] undo more numa maxnode confusions
>   Date: Mon, 13 Sep 2004 05:58:48 -0700


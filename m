Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267683AbUIMRIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267683AbUIMRIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUIMRIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:08:23 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21456 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267683AbUIMRIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:08:22 -0400
Date: Mon, 13 Sep 2004 10:07:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5 compile errors
Message-Id: <20040913100757.2be28ab6.pj@sgi.com>
In-Reply-To: <1095093355.3628.152.camel@dyn318077bld.beaverton.ibm.com>
References: <1095093355.3628.152.camel@dyn318077bld.beaverton.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For this error:

    mm/mempolicy.c: In function `get_zonemask':
    mm/mempolicy.c:419: error: `maxnode' undeclared (first use in this function)
    mm/mempolicy.c:419: error: (Each undeclared identifier is reported only once
    mm/mempolicy.c:419: error: for each function it appears in.)

See my fix on posted 4 hours ago on lkml:

  Subject: [PATCH] undo more numa maxnode confusions
  Date: Mon, 13 Sep 2004 05:58:48 -0700

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

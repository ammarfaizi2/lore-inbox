Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUHQBdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUHQBdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 21:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268069AbUHQBdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 21:33:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21209 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268073AbUHQBct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 21:32:49 -0400
Subject: Re: 2.6.8.1-mm1
From: Nathan Lynch <nathanl@austin.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <121120000.1092699569@flay>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	 <121120000.1092699569@flay>
Content-Type: text/plain
Message-Id: <1092706344.3081.4.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 20:32:24 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 18:39, Martin J. Bligh wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm1
> 
> make install from this config file:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/config.numaq
> 
> results in this failure:
> 
> make: *** No rule to make target `.tmp_kallsyms2.S', needed by `.tmp_kallsyms2.o'.  Stop.

I hit the same thing on ppc64 with gcc 3.3.2-ish.  Doing a non-parallel
make (i.e. without -j) seems to work around it for me.

Nathan



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVAWMWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVAWMWT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 07:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVAWMWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 07:22:19 -0500
Received: from ns.suse.de ([195.135.220.2]:64493 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261297AbVAWMWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 07:22:17 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 1/13] Qsort
Date: Sun, 23 Jan 2005 13:22:13 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
References: <20050122203326.402087000@blunzn.suse.de> <200501230608.36501.agruen@suse.de> <20050123053255.GT12076@waste.org>
In-Reply-To: <20050123053255.GT12076@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501231322.14332.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 January 2005 06:32, Matt Mackall wrote:
> Yes, indeed. Though I think even here, we'd prefer to use kmalloc
> because gcc generates suboptimal code for variable-sized stack vars.

That's ridiculous. kmalloc isn't even close to whatever suboptimal code gcc 
might produce here. Also I'm not convinced that gcc generates bad code in the 
first place. The code I get makes perfect sense.

-- Andreas.

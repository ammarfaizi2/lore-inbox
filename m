Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVBYGtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVBYGtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 01:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVBYGtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 01:49:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:19870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262614AbVBYGtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 01:49:17 -0500
Date: Thu, 24 Feb 2005 22:49:09 -0800
From: Chris Wright <chrisw@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: sds@epoch.ncsc.mil, Andrew Morton OSDL <akpm@osdl.org>, serue@us.ibm.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] audit: handle loginuid through proc
Message-ID: <20050225064909.GD28536@shell0.pdx.osdl.net>
References: <1109312092.5125.187.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109312092.5125.187.camel@cube>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Albert Cahalan (albert@users.sourceforge.net) wrote:
> Assuming you'd like ps to print the LUID, how about
> putting it with all the others? There are "Uid:"
> lines in the /proc/*/status files.

It's also set (written) via /proc, so it should probably stay separate.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

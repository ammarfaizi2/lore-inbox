Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVCOARq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVCOARq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 19:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVCOAPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 19:15:50 -0500
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:39654
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S261761AbVCOAPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 19:15:31 -0500
Date: Tue, 15 Mar 2005 00:15:26 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] procfs: convert to C99 inits.
Message-ID: <20050315001526.GC6903@home.fluff.org>
References: <20050314160329.456ce70b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050314160329.456ce70b.rddunlap@osdl.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 04:03:29PM -0800, Randy.Dunlap wrote:
> (resend)
> 
> Use C99 struct inits as requested by sparse:
> fs/proc/base.c:738:2: warning: obsolete struct initializer, use C99 syntax
> fs/proc/base.c:739:2: warning: obsolete struct initializer, use C99 syntax

I posted a patch for this, and an included `__user` missing
from the self-same set of functions a short while ago.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

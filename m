Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUIMPRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUIMPRH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUIMPQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:16:19 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:6309 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S267749AbUIMPJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:09:44 -0400
Date: Mon, 13 Sep 2004 11:08:51 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] BSD Jail LSM (2/3)
Message-ID: <20040913150851.GA15000@escher.cs.wm.edu>
References: <1094847705.2188.94.camel@serge.austin.ibm.com> <1094847787.2188.101.camel@serge.austin.ibm.com> <1094844708.18107.5.camel@localhost.localdomain> <20040912233342.GA12097@escher.cs.wm.edu> <1095072996.14355.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095072996.14355.12.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
From: hallyn@CS.WM.EDU (Serge E. Hallyn)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> On Llu, 2004-09-13 at 00:33, Serge E. Hallyn wrote:
> > Right now one must choose between either an ipv4 or ipv6 interface.
> > Is typical ipv6 usage such that it would be preferable to be able to
> > specify one of each?  
> 
> Its normal to have both yes.
> 
> A more interesting question is whether all of the "which socket for
> which use" stuff could be addressed by netfilter chains run at
> bind/connect time ?

You mean to add two new netfilter hooks?  Would these then replace the
LSM hooks?

-serge

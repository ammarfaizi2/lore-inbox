Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbUKEJtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbUKEJtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 04:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUKEJtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 04:49:42 -0500
Received: from gyre.foreca.com ([193.94.59.26]:48847 "EHLO gyre.weather.fi")
	by vger.kernel.org with ESMTP id S262637AbUKEJtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 04:49:23 -0500
Date: Fri, 5 Nov 2004 11:49:10 +0200 (EET)
From: =?ISO-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko@hyvatti.iki.fi>
X-X-Sender: jaakko@gyre.weather.fi
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and nfsd do not work under load (Re: x86_64, LOCKUP on
 CPU0, kjournald)
In-Reply-To: <20041101013150.2ab0aaa5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0411031652550.14341@gyre.weather.fi>
References: <Pine.LNX.4.58.0410260818560.3400@gyre.weather.fi>
 <Pine.LNX.4.58.0411010847180.2172@gyre.weather.fi> <20041101013150.2ab0aaa5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Andrew Morton wrote:
> I'd suggest that you either recompile this vendor kernel with
> CONFIG_DEBUG_SLAB=y or try a later kernel.org kernel and see if it's fixed.

  A funny detail.  CONFIG_DEBUG_SLAB=y makes kernel.org 2.6.9 refuse
rlogin and telnet connections, I suppose because of problems with pty
allocations.  Cannot find any debug anywhere about this.  Ssh and console
logins work.  So I cannot enable CONFIG_DEBUG_SLAB.  Will proceed with
2.6.9 though.  I'll report when it hangs if it hangs.

Jaakko

-- 
Foreca Ltd                                           Jaakko.Hyvatti@foreca.com
Pursimiehenkatu 29-31 B, FIN-00150 Helsinki, Finland     http://www.foreca.com

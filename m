Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbTCECNE>; Tue, 4 Mar 2003 21:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbTCECNE>; Tue, 4 Mar 2003 21:13:04 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35089
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267013AbTCECND>; Tue, 4 Mar 2003 21:13:03 -0500
Subject: Re: Kernel bloat 2.4 vs. 2.5
From: Robert Love <rml@tech9.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@digeo.com>, Daniel Egger <degger@fhm.edu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030305015957.GA27985@f00f.org>
References: <1046817738.4754.33.camel@sonja>
	 <20030304154105.7a2db7fa.akpm@digeo.com>  <20030305015957.GA27985@f00f.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046830980.999.78.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 04 Mar 2003 21:23:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 20:59, Chris Wedgwood wrote:

> I can't see it helping *that* much, for me I have:
> 
>     charon:~/wk/linux% size 2.4.x-cw/vmlinux bk-2.5.x/vmlinux
>        text    data     bss     dec     hex filename
>     2003887  120260  191657 2315804  23561c 2.4.x-cw/vmlinux
>     2411323  267551  181004 2859878  2ba366 bk-2.5.x/vmlinux
> 
>     gcc version 2.95.4 20011002 (Debian prerelease)

Ugh look at that increase in data.  Is this SMP?

	Robert Love


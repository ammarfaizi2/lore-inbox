Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUAUS60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 13:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUAUS60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 13:58:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:61071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266075AbUAUS6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 13:58:07 -0500
Date: Wed, 21 Jan 2004 10:58:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: gcs@lsc.hu, util@deuroconsult.ro, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.1-mm5 - oops during network initialization
Message-Id: <20040121105836.526c943b.akpm@osdl.org>
In-Reply-To: <200401211659.i0LGxqHX002960@turing-police.cc.vt.edu>
References: <20040120000535.7fb8e683.akpm@osdl.org>
	<200401210638.i0L6cpeU003057@turing-police.cc.vt.edu>
	<Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro>
	<20040121154627.GB10508@lsc.hu>
	<200401211659.i0LGxqHX002960@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Wed, 21 Jan 2004 16:46:27 +0100, GCS said:
> 
> > > > CONFIG_IPV6_PRIVACY=y
> >  Can you both try it without the above? At least it's solved my problem, and
> > I can have 'CONFIG_IPV6=y' and ipv6 netfilter options as modules.
> 
> Confirm on that.  Same config, turn off CONFIG_IPV6_PRIVACY, and the
> kernel boots just fine.  I'm willing to test patches if needed....
> 

Which kernel fails to boot?  There were ipv6 fixes applied to 2.6.2-rc1.

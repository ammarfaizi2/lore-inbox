Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbVCEGmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbVCEGmD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVCEGfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:35:32 -0500
Received: from [139.30.44.16] ([139.30.44.16]:6379 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263232AbVCEGad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 01:30:33 -0500
Date: Sat, 5 Mar 2005 07:29:50 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
cc: Jay Lan <jlan@sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Kaigai Kohei <kaigai@ak.jp.nec.com>, jbarnes@sgi.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] end-of-proces handling for acct-csa
In-Reply-To: <1109749735.8422.104.camel@frecb000711.frec.bull.fr>
Message-ID: <Pine.LNX.4.53.0503050726090.31083@gockel.physik3.uni-rostock.de>
References: <421EA8FF.1050906@sgi.com>  <20050224204646.704680e9.akpm@osdl.org>
  <1109314660.1738.206.camel@frecb000711.frec.bull.fr>  <42236979.5030702@sgi.com>
  <1109662409.8594.50.camel@frecb000711.frec.bull.fr>  <4224AF3D.3010803@sgi.com>
 <1109749735.8422.104.camel@frecb000711.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Guillaume Thouvenin wrote:

> Is it possible to merge BSD and CSA? I mean with CSA, there is a part
> that does per-process accounting. For exemple in the
> linux-2.6.9.acct_mm.patch the two functions update_mem_hiwater() and
> csa_update_integrals() update fields in the current (and parent)
> process. So maybe you can improve the BSD per-process accounting or
> maybe CSA can replace the BSD per-process accounting?

Yes, that was also my preferred direction - make CSA able to also write
BSD acct format, and replace the existing BSD accounting with CSA.
However it seems this will still increase the amount of kernel code quite 
a bit.

Sorry for not going into any details, I have to leave right now and will 
be offline for two weeks.

Tim

Return-Path: <linux-kernel-owner+w=401wt.eu-S932578AbXAJBxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbXAJBxv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 20:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbXAJBxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 20:53:51 -0500
Received: from koto.vergenet.net ([210.128.90.7]:46162 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932578AbXAJBxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 20:53:50 -0500
Date: Wed, 10 Jan 2007 10:53:34 +0900
From: Horms <horms@verge.net.au>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [PATCH] Kdump documentation update for 2.6.20
Message-ID: <20070110015333.GC21005@verge.net.au>
References: <20070110003110.GC28721@verge.net.au> <10EA09EFD8728347A513008B6B0DA77A086BA1@pdsmsx411.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A086BA1@pdsmsx411.ccr.corp.intel.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 09:34:12AM +0800, Zou, Nanhai wrote:
> > >
> > > I am hoping it --args-linux will be required while loading vmlinux on
> > > IA64? Because this is ELF file specific option. And this interface should
> > > be common across all the architectures.
> > >
> > > > Then again, I could be wrong, I'm not sure that I understand
> > > > --args-linux, I just know that I'm not using it :)
> > 
> > I will take a look into this.
> > 
>  args-linux is not support by IA64 kdump. 
> To have common interface, maybe we should support it by ignore this
> arg like ppc does.

That sounds reasonable to me. Vivek, what do you think?

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


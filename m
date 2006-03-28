Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWC1ICN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWC1ICN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWC1ICN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:02:13 -0500
Received: from ns1.siteground.net ([207.218.208.2]:48054 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751369AbWC1ICL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:02:11 -0500
Date: Tue, 28 Mar 2006 00:02:58 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Message-ID: <20060328080257.GA3581@localhost.localdomain>
References: <20060325223358sho@rifu.tnes.nec.co.jp> <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com> <20060327131049.2c6a5413.akpm@osdl.org> <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1143530126.11560.6.camel@openx2.frec.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 09:15:26AM +0200, Laurent Vivier wrote:
> Le mar 28/03/2006 à 00:58, Ravikiran G Thirumalai a écrit :
> > On Mon, Mar 27, 2006 at 01:10:49PM -0800, Andrew Morton wrote:
> > > Mingming Cao <cmm@us.ibm.com> wrote:
> 
> As 64bit per cpu counter is used only by ext3 and needed only on 64bit

No, per-cpu counters are generic, and used for nr_files counter in vfs, and
struct  proto.memory_allocated in net (on current -mm). 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965274AbWFAGgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbWFAGgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 02:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbWFAGgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 02:36:52 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:8862 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965274AbWFAGgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 02:36:51 -0400
Date: Thu, 1 Jun 2006 08:35:39 +0200
From: Voluspa <lista1@comhem.se>
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: Valdis.Kletnieks@vt.edu, diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Adaptive Readahead V14 - statistics question...
Message-Id: <20060601083539.5b783e6e.lista1@comhem.se>
In-Reply-To: <349141076.14929@ustc.edu.cn>
References: <20060530053631.57899084.lista1@comhem.se>
	<200605301649.k4UGnooZ004266@turing-police.cc.vt.edu>
	<20060531235021.41a58425.lista1@comhem.se>
	<349141076.14929@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 13:51:43 +0800 Fengguang Wu wrote:
> On Wed, May 31, 2006 at 11:50:21PM +0200, Voluspa wrote:
> > _Massive READ_
> > 
> > [/usr had some 490000 files]
> > 
> > "cd /usr ; time find . -type f -exec md5sum {} \;"
> > 
> > 2.6.17-rc5 ------- 2.6.17-rc5-ar
> > 
> > real 21m21.009s -- 21m37.663s
> > user 3m20.784s  -- 3m20.701s
> > sys  6m34.261s  -- 6m41.735s
> > 
> > I had planned to run this at least three times, but didn't realize I had
> > 12 compiled kernel trees and 3 uncompiled there... So, a one-shot had to
> > do. But it's still significant.
> 
> Sorry, it is a known regression. I'd like to fix it in the next
> release.

That's cool. I had fun testing (I'm weird) and now have a fixed procedure
to monitor your future work. When/if it hits mainline I'll both back it out
and switch it on/off. Then shout WOLF if I see a regression anywhere ;)

There's still the readahead size to adjust. I'll return with my findings.

Mvh
Mats Johannesson
--

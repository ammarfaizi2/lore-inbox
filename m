Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVDZRrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVDZRrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDZRjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:39:32 -0400
Received: from mail.shareable.org ([81.29.64.88]:22441 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261505AbVDZRit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:38:49 -0400
Date: Tue, 26 Apr 2005 18:38:33 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: john@stoffel.org, dedekind@oktetlabs.ru, v@iki.fi,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050426173833.GA17001@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <20050426152434.GB14297@mail.shareable.org> <20050426192220.4979de4d.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426192220.4979de4d.diegocg@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> > It's even harder without kernel support! :)
> 
> This seems to implement something in userspace which might be interesting:
> http://users.auriga.wearlab.de/~alb/libjio/

Thanks.  That looks like a handy little library.

It doesn't do full filesystem transactions, obviously.  Just
transactions within a single file, and requiring all processes using
the file to cooperate.

-- Jamie


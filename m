Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVAHCVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVAHCVC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 21:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVAHCVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 21:21:02 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:488 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261772AbVAHCU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 21:20:57 -0500
Date: Fri, 7 Jan 2005 18:20:29 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hch@infradead.org, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, greghk@us.ibm.com,
       torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050108022029.GG1267@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org> <20050106162928.650e9d71.akpm@osdl.org> <20050107002624.GA29006@infradead.org> <20050107090014.GA24946@elte.hu> <20050107091542.GA5295@infradead.org> <20050107140034.46aec534.akpm@osdl.org> <1105136713.7079.14.camel@localhost.localdomain> <20050107161225.2a09aeb5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107161225.2a09aeb5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:12:25PM -0800, Andrew Morton wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > 
> > People have been trying to get this stuff fixed for a long time. There
> > are no sane users of it, there are no apparent legal users of it and the
> > one remaining problem has shown no sign of wishing to change and will no
> > doubt try the same again in twelve months.
> 
> I doubt if that is correct.  Paul?

If MVFS tries the same again in twelve months, they will be going through
some representative other than myself.  In fact, if MVFS does not have
a credible plan for accommodating a twelve-months-from-now loss of these
exports within 30 days, their management will be hearing from me.

						Thanx, Paul

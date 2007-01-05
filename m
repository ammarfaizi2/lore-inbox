Return-Path: <linux-kernel-owner+w=401wt.eu-S1030313AbXAEEfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbXAEEfY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 23:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030316AbXAEEfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 23:35:23 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:38223 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030315AbXAEEfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 23:35:23 -0500
Date: Thu, 4 Jan 2007 22:35:12 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Frederik Deweerdt <deweerdt@free.fr>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 8/8] user ns: implement user ns unshare
Message-ID: <20070105043512.GA1412@sergelap.austin.ibm.com>
References: <20070104180635.GA11377@sergelap.austin.ibm.com> <20070104181310.GI11377@sergelap.austin.ibm.com> <20070104190700.GB17863@slug> <200701042223.l04MNZB2002002@turing-police.cc.vt.edu> <20070104225253.GA3087@sergelap.austin.ibm.com> <200701050202.l0522sS2004940@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701050202.l0522sS2004940@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
> On Thu, 04 Jan 2007 16:52:53 CST, "Serge E. Hallyn" said:
> > Quoting Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
> > > On Thu, 04 Jan 2007 19:07:00 GMT, Frederik Deweerdt said:
> > > > >  	int err = 0;
> > > >         ^^^^^^^^^^^^
> > > > The "= 0" is superfluous here.
> > >
> > > Umm?  bss gets cleared automagically, but when did we start auto-zeroing
> > > the stack?
> >
> > No, no, that's what i thought he meant at first too, but I actually
> > manually set err on all paths anyway  :)
> 
> Oh.  So it's *really* just "superfluous until somebody changes the code"...

True.

-serge

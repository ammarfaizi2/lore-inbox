Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUCSOAo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUCSOAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:00:44 -0500
Received: from styx.suse.cz ([82.208.2.94]:25472 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S263004AbUCSOAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:00:43 -0500
Date: Fri, 19 Mar 2004 15:00:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Aubin LaBrosse <arl8778@rit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/44] Support for scroll wheel on Office keyboards
Message-ID: <20040319140059.GC658@ucw.cz>
References: <10794467761141@twilight.ucw.cz> <1079462819.5232.257.camel@rain.rh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079462819.5232.257.camel@rain.rh.rit.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 01:46:59PM -0500, Aubin LaBrosse wrote:

> > @@ -52,6 +52,10 @@
> >  module_param_named(softrepeat, atkbd_softrepeat, bool, 0);
> >  MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");
> >  
> > +static int atkbd_scroll;
> > +module_parm_named(scroll, atkbd_scroll, bool, 0);
> > +MODULE_PARM_DESC_(scroll, "Enable scroll-wheel on office keyboards");

>    ^^forgive me if i am wrong, but should that not be
> module_param_named, like the rest? (eg the second 'a' is missing). 
> also, why MODULE_PARM_DESC_ instead of MODULE_PARM_DESC? (extra
> underscore)

It's a bug, but it's fixed in the next changeset (also submitted). It
wouldn't even compile. You can check that it's correct in the final
file.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

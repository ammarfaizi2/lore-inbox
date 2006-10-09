Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932915AbWJIO5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbWJIO5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWJIO5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:57:38 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:27603 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1751883AbWJIO5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:57:37 -0400
Date: Mon, 9 Oct 2006 16:57:06 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Theodore Tso <tytso@mit.edu>, Rik van Riel <riel@redhat.com>,
       Tim Bird <tim.bird@am.sony.com>, Darren Hart <dvhltc@us.ibm.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, "Theodore Ts'o" <theotso@us.ibm.com>
Subject: Re: Realtime Wiki - http://rt.wiki.kernel.org
Message-ID: <20061009145705.GL10251@pengutronix.de>
References: <200610051404.08540.dvhltc@us.ibm.com> <452696C8.9000009@am.sony.com> <20061006181503.GE21816@thunk.org> <4526FAD2.8010004@redhat.com> <20061007024250.GH21816@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20061007024250.GH21816@thunk.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 10:42:50PM -0400, Theodore Tso wrote:
> On Fri, Oct 06, 2006 at 08:54:42PM -0400, Rik van Riel wrote:
> > >Yep, that was part of the design.  When I approached Peter Anvin
> > >and the other kernel.org maintainers during OLS about hosting the
> > >-rt wiki on kernel.org infrastructure, what we explicitly talked
> > >about was making it easy to set up other wiki's for multiple kernel
> > >projects,
> > 
> > It would be nice to give the wikis wiki editable navigation menus,
> > like http://kernelnewbies.org/ and http://linux-mm.org/
> > 
> 
> Actually, you can edit the Navigation menu by editing
> Mediawiki:Sidebar magic page.  There are other things that you can
> edit in the Mediawiki:* namespace that affect the Wiki's overall
> navigation.
> 
> Only the Wiki sysops are allowed to edit the Mediawiki:* namespace,
> though, because of the fact that they affect the core behavior of the
> wiki, and because some of the Mediawiki:* pages use raw html, and so
> there are some cross-scripting security holes that could be a problem
> if you allowed random users to be able to edit them.
> 
> > Too many of the wikis out there become horrendously hard to navigate
> > after a few years...
> 
> Agreed, which is why you need to have wiki editors keeping track of
> whether the important pages are available either on the main page or
> within two clicks of the main page.  

Here's an idea for the main navigation menu structure:

* Menu
** Software
** Documentation
** Tips & Tricks
** Tests & Benchmarks
** Projects

* More Information
** Mailinglists
** IRC
** Links

* Wiki
** mainpage|mainpage
** recentchanges-url|recentchanges
** randompage-url|randompage
** helppage|help
** http://www.kernel.org/faq/#donations|sitesupport

That should cover all the pages currently linked from the main page.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


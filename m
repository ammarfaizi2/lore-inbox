Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWJGCn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWJGCn3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWJGCn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:43:29 -0400
Received: from thunk.org ([69.25.196.29]:3521 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932681AbWJGCn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:43:28 -0400
Date: Fri, 6 Oct 2006 22:42:50 -0400
From: Theodore Tso <tytso@mit.edu>
To: Rik van Riel <riel@redhat.com>
Cc: Tim Bird <tim.bird@am.sony.com>, Darren Hart <dvhltc@us.ibm.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, "Theodore Ts'o" <theotso@us.ibm.com>
Subject: Re: Realtime Wiki - http://rt.wiki.kernel.org
Message-ID: <20061007024250.GH21816@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Rik van Riel <riel@redhat.com>, Tim Bird <tim.bird@am.sony.com>,
	Darren Hart <dvhltc@us.ibm.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	Theodore Ts'o <theotso@us.ibm.com>
References: <200610051404.08540.dvhltc@us.ibm.com> <452696C8.9000009@am.sony.com> <20061006181503.GE21816@thunk.org> <4526FAD2.8010004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4526FAD2.8010004@redhat.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 08:54:42PM -0400, Rik van Riel wrote:
> >Yep, that was part of the design.  When I approached Peter Anvin and
> >the other kernel.org maintainers during OLS about hosting the -rt wiki
> >on kernel.org infrastructure, what we explicitly talked about was
> >making it easy to set up other wiki's for multiple kernel projects,
> 
> It would be nice to give the wikis wiki editable navigation
> menus, like http://kernelnewbies.org/ and http://linux-mm.org/
> 

Actually, you can edit the Navigation menu by editing
Mediawiki:Sidebar magic page.  There are other things that you can
edit in the Mediawiki:* namespace that affect the Wiki's overall
navigation.

Only the Wiki sysops are allowed to edit the Mediawiki:* namespace,
though, because of the fact that they affect the core behavior of the
wiki, and because some of the Mediawiki:* pages use raw html, and so
there are some cross-scripting security holes that could be a problem
if you allowed random users to be able to edit them.

> Too many of the wikis out there become horrendously hard to
> navigate after a few years...

Agreed, which is why you need to have wiki editors keeping track of
whether the important pages are available either on the main page or
within two clicks of the main page.  


						- Ted

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWCZWlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWCZWlB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWCZWlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:41:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16398 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932153AbWCZWlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:41:00 -0500
Date: Wed, 22 Mar 2006 20:59:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 26/35] Add Xen subarch reboot support
Message-ID: <20060322205919.GA2384@ucw.cz>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063801.949835000@sorel.sous-sol.org> <200603221521.57639.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221521.57639.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-03-06 15:21:57, Andi Kleen wrote:
> On Wednesday 22 March 2006 07:31, Chris Wright wrote:
> > +       static char *envp[] = { "HOME=/", "TERM=linux",
> > +                               "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
> > +       static char *restart_argv[]  = { "/sbin/reboot", NULL };
> > +       static char *poweroff_argv[] = { "/sbin/poweroff", NULL };
> 
> It would be better if that was user configurable.

acpi also needs to shutdown machine on overheat. It would be nice to
consolidate all those places. New signal to init would be best, I'd
say.

-- 
Thanks, Sharp!

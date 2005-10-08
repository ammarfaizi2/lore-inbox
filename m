Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbVJHAO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbVJHAO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbVJHAO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:14:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43455 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161018AbVJHAO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:14:58 -0400
Date: Fri, 7 Oct 2005 20:14:04 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, airlied@gmail.com
Subject: Re: [stable] Re: [patch 4/7] sysfs: Signedness problem
Message-ID: <20051008001404.GP31529@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk, airlied@gmail.com
References: <20051007234348.631583000@press.kroah.org> <20051007235450.GE23111@kroah.com> <20051008000252.GO31529@redhat.com> <20051008000720.GC23609@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051008000720.GC23609@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 05:07:20PM -0700, Greg Kroah-Hartman wrote:
 > On Fri, Oct 07, 2005 at 08:02:52PM -0400, Dave Jones wrote:
 > > On Fri, Oct 07, 2005 at 04:54:50PM -0700, Greg KH wrote:
 > > 
 > >  > Please consider for next 2.6.13, it is a minor security issue allowing
 > >  > users to turn on drm debugging when they shouldn't...
 > >  > 
 > >  > This fell through the cracks. Until Josh pointed me at
 > >  > http://bugs.gentoo.org/show_bug.cgi?id=107893
 > >  > 
 > >  > Signed-off-by: Chris Wright <chrisw@osdl.org>
 > >  > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
 > > 
 > > For those scratching their heads, the subject line came
 > > about as a result of my following up an older issue.
 > > This has nothing to do with signedness of course :-)
 > 
 > Heh, ok, care to suggest a better Subject: ?

"Fix incorrect permissions on DRM debug sysfs entry"  ?

		Dave


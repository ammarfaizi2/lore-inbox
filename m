Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbVJHAHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbVJHAHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbVJHAHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:07:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:60378 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161014AbVJHAHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:07:48 -0400
Date: Fri, 7 Oct 2005 17:07:20 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, airlied@gmail.com
Subject: Re: [stable] Re: [patch 4/7] sysfs: Signedness problem
Message-ID: <20051008000720.GC23609@kroah.com>
References: <20051007234348.631583000@press.kroah.org> <20051007235450.GE23111@kroah.com> <20051008000252.GO31529@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051008000252.GO31529@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 08:02:52PM -0400, Dave Jones wrote:
> On Fri, Oct 07, 2005 at 04:54:50PM -0700, Greg KH wrote:
> 
>  > Please consider for next 2.6.13, it is a minor security issue allowing
>  > users to turn on drm debugging when they shouldn't...
>  > 
>  > This fell through the cracks. Until Josh pointed me at
>  > http://bugs.gentoo.org/show_bug.cgi?id=107893
>  > 
>  > Signed-off-by: Chris Wright <chrisw@osdl.org>
>  > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> For those scratching their heads, the subject line came
> about as a result of my following up an older issue.
> This has nothing to do with signedness of course :-)

Heh, ok, care to suggest a better Subject: ?

thanks,

greg k-h

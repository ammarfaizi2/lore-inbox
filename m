Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbVJHADq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVJHADq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbVJHADq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:03:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38075 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161012AbVJHADp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:03:45 -0400
Date: Fri, 7 Oct 2005 20:02:52 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, airlied@gmail.com
Subject: Re: [patch 4/7] sysfs: Signedness problem
Message-ID: <20051008000252.GO31529@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk, airlied@gmail.com
References: <20051007234348.631583000@press.kroah.org> <20051007235450.GE23111@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051007235450.GE23111@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2005 at 04:54:50PM -0700, Greg KH wrote:

 > Please consider for next 2.6.13, it is a minor security issue allowing
 > users to turn on drm debugging when they shouldn't...
 > 
 > This fell through the cracks. Until Josh pointed me at
 > http://bugs.gentoo.org/show_bug.cgi?id=107893
 > 
 > Signed-off-by: Chris Wright <chrisw@osdl.org>
 > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

For those scratching their heads, the subject line came
about as a result of my following up an older issue.
This has nothing to do with signedness of course :-)

		Dave


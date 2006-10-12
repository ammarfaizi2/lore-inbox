Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932700AbWJLQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbWJLQxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWJLQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:53:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932700AbWJLQxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:53:19 -0400
Date: Thu, 12 Oct 2006 12:51:28 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Theodore Tso <tytso@mit.edu>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [patch 00/67] 2.6.18-stable review
Message-ID: <20061012165128.GC21149@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Theodore Tso <tytso@mit.edu>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20061011210310.GA16627@kroah.com> <20061012004244.GA9252@thunk.org> <20061012163522.GE20868@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012163522.GE20868@kroah.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 09:35:22AM -0700, Greg Kroah-Hartman wrote:
 > On Wed, Oct 11, 2006 at 08:42:44PM -0400, Theodore Tso wrote:
 > > On Wed, Oct 11, 2006 at 02:03:10PM -0700, Greg KH wrote:
 > > > And yes, we realize that this is a large number of patches, sorry...
 > > 
 > > I number of these patches were cleanups, such as removing code betewen
 > > #if 0, removing header files from being exported, etc.  Not bad
 > > things, but I wouldn't have thought it would have met the criteria for
 > > being added to -stable.  Are you intentionally relaxing the criteria?
 > 
 > The header file stuff was intentionally added, as it is good to have the
 > header files exported properly.  Those were a large number of these
 > patches.

Indeed. I see this as just 'finishing the job' rather than fixing something
that's busted though.   That said, I was also carrying these in what will
be our 2.6.18 based update kernel for FC5 (and what will be FC6) for the
same reasons.

	Dave

-- 
http://www.codemonkey.org.uk

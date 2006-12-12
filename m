Return-Path: <linux-kernel-owner+w=401wt.eu-S932310AbWLLSDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWLLSDm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWLLSDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:03:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbWLLSDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:03:41 -0500
Date: Tue, 12 Dec 2006 13:03:35 -0500
From: Dave Jones <davej@redhat.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: PAE/NX without performance drain?
Message-ID: <20061212180335.GE2140@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Richard Moser <nigelenki@comcast.net>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <457B1F02.7030409@comcast.net> <1165743478.27217.187.camel@laptopd505.fenrus.org> <457C28F8.4050409@comcast.net> <1165779603.27217.231.camel@laptopd505.fenrus.org> <457C747A.6010702@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457C747A.6010702@comcast.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 03:56:26PM -0500, John Richard Moser wrote:

 > > other distros ship a PAE enabled kernel, and use that for NX enabled
 > > machines (all NX capable machines support PAE obviously). I'm surprised
 > > Ubuntu doesn't, maybe ask them? (Or use a distro that does have this)
 > > 
 > 
 > OpenSuSE and Fedora Core 6 both fail this; I checked the .config for the
 > default kernels (by proxy on OpenSuSE 10.2; I asked someone) and ran my
 > test case on FC6 (LiveCD from
 > http://www.fedoraunity.org/news-archives/fedora-core-6-zod-live-spins-released).

The livecd has a single kernel I believe.  The 'real' FC6 release
has both a PAE and non-PAE kernel as Arjan described.

		Dave

-- 
http://www.codemonkey.org.uk

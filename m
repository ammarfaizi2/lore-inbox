Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWAUTmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWAUTmn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 14:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWAUTmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 14:42:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11198 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751200AbWAUTmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 14:42:43 -0500
Date: Sat, 21 Jan 2006 14:41:02 -0500
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
Message-ID: <20060121194102.GB28051@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>
References: <20060119030251.GG19398@stusta.de> <20060118194103.5c569040.akpm@osdl.org> <1137833547.2978.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137833547.2978.7.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 09:52:27AM +0100, Arjan van de Ven wrote:
 > On Wed, 2006-01-18 at 19:41 -0800, Andrew Morton wrote:
 > > Adrian Bunk <bunk@stusta.de> wrote:
 > > >
 > > > Let's do the scheduled removal of the obsolete raw driver in 2.6.17.
 > > > 
 > > 
 > > heh.  I was just thinking that I hadn't heard from Badari and Ken in a while.
 > > 
 > > I doubt if this'll fly.  We're stuck with it.
 > 
 > One thing we can do is ask the distributions to stop shipping raw first,
 > to see what the fallout is (and to give it as a sign that it's an
 > obsolete interface). Then a  year or two after that....

It's been off in Fedora since FC4.
RHEL4 had it enabled after several vendors complained a lot about its
absense breaking an installed userbase, though they were told it would be
enabled with the proviso that it would go away in the future.
RHEL5 isn't even in beta yet, but I can already hear the voices asking
for it be reenabled..

		Dave


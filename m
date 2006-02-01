Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWBAQDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWBAQDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbWBAQDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:03:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44488 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422658AbWBAQDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:03:42 -0500
Date: Wed, 1 Feb 2006 11:03:24 -0500
From: Dave Jones <davej@redhat.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch -mm4] i386: __init should be __cpuinit
Message-ID: <20060201160324.GA5875@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	Andrew Morton <akpm@osdl.org>, Ashok Raj <ashok.raj@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Chuck Ebbert <76306.1226@compuserve.com>
References: <200601312352_MC3-1-B748-FCE9@compuserve.com> <200601312352_MC3-1-B748-FCE9@compuserve.com> <20060201053357.GA5335@redhat.com> <E1F4Czv-00018m-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1F4Czv-00018m-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 08:05:51AM +0000, Matthew Garrett wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > Especially as for the bulk of them, those CPUs aren't hotplug capable.
 > > (I seriously doubt we'll ever see a hotplugable cyrix for eg, which
 > >  takes up the bulk of your diff).
 > 
 > For SMP systems, suspend/resume "unplugs" all non-boot CPUs before
 > executing the suspend code. I don't recall any SMP cyrix systems, but
 > it's potentially something to consider.

There weren't any.  Until AMD's Athlon MPs, Intel had the only
SMP x86 afair.

		Dave


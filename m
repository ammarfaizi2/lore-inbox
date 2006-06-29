Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWF2UJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWF2UJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWF2UJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:09:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30399 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932392AbWF2UJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:09:36 -0400
Date: Thu, 29 Jun 2006 16:09:25 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, alexey.y.starikovskiy@intel.com
Subject: Re: [RFC] Adding queue_delayed_work_on interface for workqueues
Message-ID: <20060629200925.GB13619@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, alexey.y.starikovskiy@intel.com
References: <20060628141028.A13221@unix-os.sc.intel.com> <20060628143242.486f9b15.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628143242.486f9b15.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 02:32:42PM -0700, Andrew Morton wrote:

 > > This patch is a part of cpufreq patches for ondemand governor optimizations
 > > and entire series is actually posted to cpufreq mailing list.
 > > Subject "minor optimizations to ondemand governor"
 > > 
 > > The following patch however is a generic change to workqueue interface and 
 > > I wanted to get comments on this on lkml.
 > > 
 > > ...
 > >
 > > Add queue_delayed_work_on() interface for workqueues.
 > 
 > It looks sensible to me.

*nod*, same here.

As (for now) cpufreq is the only user of this, any objection to
me marshalling this through the cpufreq tree (+ the cleanups you
suggested of course) ?

		Dave

-- 
http://www.codemonkey.org.uk

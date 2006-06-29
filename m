Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWF2UlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWF2UlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWF2UlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:41:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932451AbWF2UlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:41:03 -0400
Date: Thu, 29 Jun 2006 13:44:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org,
       alexey.y.starikovskiy@intel.com
Subject: Re: [RFC] Adding queue_delayed_work_on interface for workqueues
Message-Id: <20060629134420.1735adcc.akpm@osdl.org>
In-Reply-To: <20060629200925.GB13619@redhat.com>
References: <20060628141028.A13221@unix-os.sc.intel.com>
	<20060628143242.486f9b15.akpm@osdl.org>
	<20060629200925.GB13619@redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> On Wed, Jun 28, 2006 at 02:32:42PM -0700, Andrew Morton wrote:
> 
>  > > This patch is a part of cpufreq patches for ondemand governor optimizations
>  > > and entire series is actually posted to cpufreq mailing list.
>  > > Subject "minor optimizations to ondemand governor"
>  > > 
>  > > The following patch however is a generic change to workqueue interface and 
>  > > I wanted to get comments on this on lkml.
>  > > 
>  > > ...
>  > >
>  > > Add queue_delayed_work_on() interface for workqueues.
>  > 
>  > It looks sensible to me.
> 
> *nod*, same here.
> 
> As (for now) cpufreq is the only user of this, any objection to
> me marshalling this through the cpufreq tree (+ the cleanups you
> suggested of course) ?
> 

Is OK by me.

It's good to point out the presence of out-of-scope things like this in the
eventual Linus pull request.

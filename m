Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWFBAlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWFBAlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 20:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWFBAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 20:41:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:40223 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750701AbWFBAl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 20:41:29 -0400
X-IronPort-AV: i="4.05,199,1146466800"; 
   d="scan'208"; a="45750108:sNHT22838172"
Subject: Re: [patch 1/3] acpi: dock driver v6
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
In-Reply-To: <20060601162039.02fcd8e1.akpm@osdl.org>
References: <20060412221027.472109000@intel.com>
	 <1144880322.11215.44.camel@whizzy> <20060412222735.38aa0f58.akpm@osdl.org>
	 <1145054985.29319.51.camel@whizzy> <44410360.6090003@sgi.com>
	 <1145383396.10783.32.camel@whizzy> <1146268318.25490.33.camel@whizzy>
	 <1147373152.15308.14.camel@whizzy> <1149203128.14279.17.camel@whizzy>
	 <20060601162039.02fcd8e1.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 17:53:17 -0700
Message-Id: <1149209597.14279.27.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 02 Jun 2006 00:41:26.0118 (UTC) FILETIME=[478AC060:01C685DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 16:20 -0700, Andrew Morton wrote:
> Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> >
> > Changed from last version:
> 
> It would be much preferred if you could issue patches against the previous
> version please (ie: the thing in -mm), instead of reissuing the patch each
> time.
> 

Sorry, another maintainer I routinely post patches too always preferred
me to just redo the whole patch so that he could just drop the old one.
I'll change my procedure for this patch.  If you do have a set of
guidelines for when to know whether to redo entire patches vs. patch
your patch so to speak, it'd be educational for me to hear it - as it is
I just get trained by the person I usually submit to and adopt his
process, making things work really well for me submitting to him, but
probably not so well for me when I submit to others.

I also usually patch/test against 2.6-git - mainly because I imagined
that this hopefully limits weird bugs to problems that I've actually
introduced instead of someone elses bugs - which is why I didn't notice
that acpi_os_free had been removed (although even if it hadn't I
shouldn't be using it anyway - ugh.).  Thanks for fixing the mistake,
looks like I should test against -mm and -git in the future.

Kristen

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUHTT1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUHTT1H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUHTTZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:25:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48557 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268679AbUHTTZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:25:29 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [PATCH] cleanup ACPI numa warnings
Date: Fri, 20 Aug 2004 15:22:41 -0400
User-Agent: KMail/1.6.2
Cc: Alex Williamson <alex.williamson@hp.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Paul Jackson <pj@sgi.com>,
       haveblue@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
References: <1091738798.22406.9.camel@tdi> <2550950000.1092019997@[10.10.2.4]> <1093028151.4993.42.camel@tdi>
In-Reply-To: <1093028151.4993.42.camel@tdi>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201522.41334.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 2:55 pm, Alex Williamson wrote:
>    I'm not sure where we stand on this, sorry for the delay.  To recap,
> the first patch I submitted cleaned up the original functions, but moved
> the ugliness up into multi-line macros.  People didn't like the macros
> and suggested static inlines.  However, static inlines don't work for
> this application because the debug print needs state setup by the
> ACPI_FUNCTION_NAME call.  IMHO, it's not worth setting up that state in
> the static inline function for this little bit of cleanup.
>
>    So, I think we left it at nobody liked the macros and static inlines
> don't work.  General unhappiness.  Below is a patch that doesn't attempt
> to cleanup the original code, it just adds the #ifdefs and range
> checking w/ no macros.  Does this look better?  Below is the original
> submit comment outlining the goal.  Thanks,

Yes please.

Jesse

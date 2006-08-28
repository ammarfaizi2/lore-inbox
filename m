Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWH1QaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWH1QaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWH1QaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:30:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:35953 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751149AbWH1QaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:30:13 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="116225480:sNHT17292464"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] maximum latency tracking infrastructure (version 3)
Date: Mon, 28 Aug 2006 09:30:45 -0700
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       dwalker@mvista.com
References: <1156780080.3034.207.camel@laptopd505.fenrus.org> <200608280925.34326.jesse.barnes@intel.com> <44F318F8.3050100@linux.intel.com>
In-Reply-To: <44F318F8.3050100@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608280930.45273.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 28, 2006 9:25 am, Arjan van de Ven wrote:
> Jesse Barnes wrote:
> > On Monday, August 28, 2006 8:48 am, Arjan van de Ven wrote:
> >> 3rd version; only minor changes this time, the sysreq stuff is gone
> >> however.
> >>
> >> I've decided to not use a namespace prefix; these functions are
> >> meant to be generic,  and a namespace prefix is not common for such
> >> functions, and it would in addition cause a too narrow usage of
> >> this infrastructure.
> >
> > Almost forgot--what about documentation?  This is an addition to the
> > driver API, so it should probably be described clearly somewhere,
> > probably in Documentation/ somewhere...
>
> how about linuxdoc??

I like to have stuff in Documentation/ too, but if you think the existing 
function comments are good enough that's fine.

Jesse

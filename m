Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWH1QZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWH1QZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWH1QZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:25:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:54692 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750792AbWH1QZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:25:01 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="122267072:sNHT17086041"
From: Jesse Barnes <jesse.barnes@intel.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] maximum latency tracking infrastructure (version 3)
Date: Mon, 28 Aug 2006 09:25:34 -0700
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       dwalker@mvista.com
References: <1156780080.3034.207.camel@laptopd505.fenrus.org>
In-Reply-To: <1156780080.3034.207.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608280925.34326.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 28, 2006 8:48 am, Arjan van de Ven wrote:
> 3rd version; only minor changes this time, the sysreq stuff is gone
> however.
>
> I've decided to not use a namespace prefix; these functions are meant
> to be generic,  and a namespace prefix is not common for such
> functions, and it would in addition cause a too narrow usage of this
> infrastructure.

Almost forgot--what about documentation?  This is an addition to the 
driver API, so it should probably be described clearly somewhere, 
probably in Documentation/ somewhere...

Jesse

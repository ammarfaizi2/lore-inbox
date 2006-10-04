Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWJDOKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWJDOKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWJDOKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:10:40 -0400
Received: from mga07.intel.com ([143.182.124.22]:18066 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S964888AbWJDOKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:10:39 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,256,1157353200"; 
   d="scan'208"; a="126809486:sNHT118982864"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
In-Reply-To: <45233B1E.3010100@goop.org>
References: <1159916644.8035.35.camel@localhost.localdomain>
	 <4522FB04.1080001@goop.org>
	 <1159919263.8035.65.camel@localhost.localdomain>
	 <45233B1E.3010100@goop.org>
Content-Type: text/plain
Organization: Intel
Date: Wed, 04 Oct 2006 06:21:35 -0700
Message-Id: <1159968095.8035.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 21:39 -0700, Jeremy Fitzhardinge wrote:

> 
> I don't think you've proved your case here.  Do you *know* there are 
> extra cache misses (ie, measuring them), or is it just your theory to 
> explain a performance regression?
> 

I have measured the cache miss with tool.  So it is not just my theory.

Tim

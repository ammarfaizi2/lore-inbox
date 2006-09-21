Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWIUUat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWIUUat (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 16:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWIUUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 16:30:49 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:985 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1750830AbWIUUat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 16:30:49 -0400
Message-ID: <4512F676.7020802@oracle.com>
Date: Thu, 21 Sep 2006 13:30:46 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Andrew Morton'" <akpm@osdl.org>,
       "'Suparna Bhattacharya'" <suparna@in.ibm.com>,
       linux-kernel@vger.kernel.org, linux-aio <linux-aio@kvack.org>
Subject: Re: [patch] clean up unused kiocb variables
References: <000101c6ddbc$334248d0$ff0da8c0@amr.corp.intel.com>
In-Reply-To: <000101c6ddbc$334248d0$ff0da8c0@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Let's remove them.  We can always add them back if there is a need.

Agreed, especially in this age of dynamic probing.

> Suparna wanted them around for debug purpose at one point.  I don't know
> whether that is still the case right now.  At least I can wrap it around
> with #if DEBUG.

I guess that's better than nothing.  Given the near total lack of
-EIOCBRETRY users I'm just not convinced that they're worth it.

- z

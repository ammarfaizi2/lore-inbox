Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264868AbUD2VYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbUD2VYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264859AbUD2VVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:21:38 -0400
Received: from [216.150.199.16] ([216.150.199.16]:59824 "EHLO mail.aspsys.com")
	by vger.kernel.org with ESMTP id S264853AbUD2VRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:17:35 -0400
Date: Thu, 29 Apr 2004 15:17:33 -0600
From: Bryan Stillwell <bryans@aspsys.com>
To: linux-kernel@vger.kernel.org
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Dual Opteron 248s w/ 8GB RAM on Tyan K8W (S2885)
Message-ID: <20040429211733.GD15563@aspsys.com>
References: <20040428225331.GA19698@aspsys.com> <200404300005.02814.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404300005.02814.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 12:05:02AM +0300, Denis Vlasenko wrote:
>Latest memtest86 rumored to support testing more than 4Gb or RAM.
>You may try it and see whether it detects all the RAM.

During the 20% chance of it actually booting up, I've been able to
capture /proc/meminfo.  It reports MemTotal as 7642992 kB.  I've been
told that Tyan boards allocate almost 0.5GB for some reason for their
own use...  You can check out the logs I made from the bugzilla report I
sent to RedHat:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=121868

You'll notice that when it has 4GB in the system, the MemTotal is
3530868 kB...  The Rioworks board recognized close to the full amount
with both 4GB and 8GB installed.

I've also tested Mandrake 10.0rc1 and SuSE 9.0, and they have the same
issues that RedHat has...

Bryan

-- 
Aspen Systems, Inc.    | http://www.aspsys.com/
Production Engineer    | Phone: (303)431-4606
bryans@aspsys.com      | Fax:   (303)431-7196

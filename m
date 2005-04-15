Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVDOUUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVDOUUs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVDOUUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:20:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52182 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261952AbVDOUUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:20:42 -0400
Subject: Re: Serverworks LE and MTRR write-combining question
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Russo <miker@readq.com>
Cc: Andrew Morton <akpm@osdl.org>, Richard Gooch <rgooch@atnf.csiro.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1113521642.19830.33.camel@mindpipe>
References: <425EF60F.9080901@readq.com>
	 <1113521642.19830.33.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 15 Apr 2005 16:20:41 -0400
Message-Id: <1113596441.23696.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 19:34 -0400, Lee Revell wrote:
> Here's the patch from that thread against 2.6.12-rc2.  It also fixes an
> unrelated typo in nearby code.  Obviously untested, as I don't have the
> hardware ;-)
> 
> Summary: Enable write combining for server works LE rev > 6 per
> http://www.ussg.iu.edu/hypermail/linux/kernel/0104.3/1007.html

OK, Mike has tested my patch with a rev 6 chipset and report that write
combining works fine.  Andrew, please apply.

Lee




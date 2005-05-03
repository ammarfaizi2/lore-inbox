Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVECNiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVECNiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 09:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVECNiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 09:38:09 -0400
Received: from orb.pobox.com ([207.8.226.5]:33939 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261522AbVECNiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 09:38:06 -0400
Date: Tue, 3 May 2005 06:37:59 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Nathan Scott <nathans@sgi.com>,
       Pavel Machek <pavel@suse.cz>, "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
Message-ID: <20050503133759.GA7647@ip68-225-251-162.oc.oc.cox.net>
References: <20050430164303.6538f47c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050430164303.6538f47c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to see the following patch added to -mm:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111326617622941&w=2

(I'm guessing that Nathan Scott will need to resubmit it with proper
changelog information.)

The patch fixes a problem where compiling XFS into the kernel (as
opposed to a module) causes swsusp resumes to be waaay slower than they
should be.

It's been tested and found to work by Pavel Machek:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111331702916365&w=2
as well as myself:
http://marc.theaimsgroup.com/?l=linux-kernel&m=111330749723995&w=2
and I've been running with it for the last couple of weeks now with no
problems.

-Barry K. Nathan <barryn@pobox.com>

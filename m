Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbVETXo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbVETXo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 19:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVETXo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 19:44:28 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:26187 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261492AbVETXoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 19:44:12 -0400
Date: Fri, 20 May 2005 16:43:53 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, Christopher Li <lkml@chrisli.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kbuild trick
Message-ID: <20050520234353.GM22946@ca-server1.us.oracle.com>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Timur Tabi <timur.tabi@ammasso.com>,
	Christopher Li <lkml@chrisli.org>, linux-kernel@vger.kernel.org
References: <428A661C.1030100@ammasso.com> <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com> <20050518132417.GA14488@64m.dyndns.org> <428B7143.4090607@ammasso.com> <20050518182250.GB8130@mars.ravnborg.org> <428B8809.8060406@ammasso.com> <20050520193706.GA8225@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520193706.GA8225@mars.ravnborg.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 09:37:06PM +0200, Sam Ravnborg wrote:
> For both kernel 2.4 and 2.6 you can split up your makefile like this:
> makefile <= all the external modules specific part
> Makefile <= the kbuild specific part

	You could also use our fake-2.6-kbuild-for-2.4 makefile,
retrievable via:

svn cat -r 2205 http://oss.oracle.com/projects/ocfs2/src/trunk/Kbuild-24.make

	Just include it and set your target to build-modules,
clean-modules, or install-modules.

Joel

-- 

To spot the expert, pick the one who predicts the job will take the
longest and cost the most.

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

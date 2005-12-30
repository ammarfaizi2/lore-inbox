Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVL3SRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVL3SRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 13:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVL3SRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 13:17:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21470 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751272AbVL3SRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 13:17:54 -0500
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com, alan@redhat.com
In-Reply-To: <20051230174817.GW15993@alpha.home.local>
References: <20051230074401.GA7501@ip68-225-251-162.oc.oc.cox.net>
	 <20051230174817.GW15993@alpha.home.local>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 19:17:46 +0100
Message-Id: <1135966666.2941.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 18:48 +0100, Willy Tarreau wrote:
> On Thu, Dec 29, 2005 at 11:44:01PM -0800, Barry K. Nathan wrote:
> > This patch adds strict VM overcommit accounting to the mainline 2.4
> > kernel, thus allowing overcommit to be truly disabled. This feature
> > has been in 2.4-ac, Red Hat Enterprise Linux 3 (RHEL 3) vendor kernels,
> > and 2.6 for a long while.
> 
> Many thanks, I'm impatient to try it ! I tried to backport it in the
> past but miserably failed as I don't understand those areas well. I'm
> interested in checking that a buggy service cannot eat all the RAM an
> bring the machine to death.

that's what rlimit is for though... overcommit acounting doesn't help
you a lot there.


Also I think, to be honest, that this is a feature that is getting
unsuitable for the "bugfixes only" 2.4 kernel series....



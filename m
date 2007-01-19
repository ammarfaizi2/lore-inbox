Return-Path: <linux-kernel-owner+w=401wt.eu-S964819AbXASELp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbXASELp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 23:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbXASELp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 23:11:45 -0500
Received: from gw.goop.org ([64.81.55.164]:58482 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964819AbXASELo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 23:11:44 -0500
Message-ID: <45B044F8.1080904@goop.org>
Date: Fri, 19 Jan 2007 15:11:36 +1100
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 16/20] XEN-paravirt: Add the Xen virtual console driver.
References: <20070113014539.408244126@goop.org> <20070113014648.767777869@goop.org> <20070115130314.GA4272@ucw.cz>
In-Reply-To: <20070115130314.GA4272@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> You have drivers/xen... so maybe arch/i386/xen is easier to type?
> arch/i386/paravirt/xen would make some sense, too, but it looks too
> deep to me.

I think the exact placement of these files needs a bit of work.  I don't
much care about xen/ vs paravirt/xen vs paravirt-xen/, but placement of
headers needs a bit more thought.  lhype, er, lguest and vmi are in
kernel/, but I think it would be nice to put them near Xen.

    J

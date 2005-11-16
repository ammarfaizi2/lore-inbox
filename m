Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbVKPVdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbVKPVdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 16:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbVKPVdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 16:33:18 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:50331 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030513AbVKPVdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 16:33:17 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Greg KH <greg@kroah.com>
Cc: "Gross, Mark" <mark.gross@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <DaveJ@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20051116164429.GA5630@kroah.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1132172445.25230.73.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 17 Nov 2005 07:20:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-11-17 at 03:44, Greg KH wrote:
> Please, everyone realize that Nigel's code is not going to be merged
> into mainline as it is today.  He knows it, and everyone else involved
> knows it.  Nigel also knows the proper procedure for getting his changes
> into mainline, if he so desires, as we all sat in a room last July and
> discussed this (lwn.net has a summary somewhere about it too...)

Do you mean "as it was in July"? I haven't been sitting on my hands
since July :)  My wife will testify to that!

I've been working on implementing the last new features I want in,
fixing bugs and generally making it as stable and reliable as I can.
(Sorry Andrew, but I'm being a perfectionist). At the same time, many of
the parts that made Suspend2 be considered huge and ugly have been
merged. The pm_message_t stuff, for example, was adopted early by
Suspend2 and part of those stats you saw in July. The patch currently
still includes the workqueue nofreeze patch, Christoph's todo list
freezer modifications. These account for virtually all of the changes
outside of kernel/power.

I've also split the one patch that most people see into what is
currently about 225 smaller patches, each adding only one small part, am
writing descriptions for them all and am preparing to build a git tree
from it.

Hopefully that shows that I am working toward merging, just maybe not in
the way that you were imagining. You'll remember that I've argued before
that trying to patch swsusp into Suspend2 is infeasible. I'm not even
trying to do it.

Regards,

Nigel

> So, here's Pavel trying to make things better and people are complaining
> about it.  Argue that the technical points are invalid (like Dave did.)
> But don't just sit around and kvetch, that doesn't help out anyone.
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 



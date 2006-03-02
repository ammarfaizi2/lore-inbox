Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWCBJtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCBJtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWCBJtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:49:20 -0500
Received: from webapps.arcom.com ([194.200.159.168]:13833 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751425AbWCBJtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:49:19 -0500
Message-ID: <4406BF95.8060501@cantab.net>
Date: Thu, 02 Mar 2006 09:49:09 +0000
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.15.5
References: <20060301231907.GR3883@sorel.sous-sol.org>
In-Reply-To: <20060301231907.GR3883@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Mar 2006 09:49:12.0609 (UTC) FILETIME=[8F7E4910:01C63DDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> We (the -stable team) are announcing the release of the 2.6.15.5
> kernel.
> 
> [...]
> 
> Alexey Kuznetsov: Fix a severe bug

Can we have more descriptive patch summaries in future?  At least
include the subsystem!

Here's the description I dug out of the web interface to git:

"netlink overrun was broken while improvement of netlink. Destination
socket is used in the place where it was meant to be source socket, so
that now overrun is never sent to user netlink sockets, when it should
be, and it even can be set on kernel socket, which results in complete
deadlock of rtnetlink."

David Vrabel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUI1Qmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUI1Qmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 12:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267987AbUI1Qmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 12:42:53 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:4516 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267984AbUI1Qmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 12:42:46 -0400
Message-ID: <41599456.6040102@nortelnetworks.com>
Date: Tue, 28 Sep 2004 10:41:58 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ray Lee <ray-lk@madrabbit.org>, rml@novell.com, ttb@tentacle.dhs.org,
       linux-kernel@vger.kernel.org, gamin-list@gnome.org,
       viro@parcelfarce.linux.theplanet.co.uk, iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
References: <1096250524.18505.2.camel@vertex>	<20040926211758.5566d48a.akpm@osdl.org>	<1096318369.30503.136.camel@betsy.boston.ximian.com>	<1096350328.26742.52.camel@orca.madrabbit.org> <20040928120830.7c5c10be.akpm@osdl.org>
In-Reply-To: <20040928120830.7c5c10be.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Why don't you pass a file descriptor into the syscall instead of a pathname?
> You can then take a ref on the inode and userspace can close the file.
> That gets you permission checking for free.

For passing in the data, that would work.  Wouldn't you still need a name or 
path when getting data back though?

Chris

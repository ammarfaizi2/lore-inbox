Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268753AbUI3FkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268753AbUI3FkH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUI3FkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:40:07 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24566 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268753AbUI3FkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:40:02 -0400
Message-ID: <415B9BB7.6070801@nortelnetworks.com>
Date: Wed, 29 Sep 2004 23:37:59 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Robert Love <rml@novell.com>, akpm@osdl.org, ttb@tentacle.dhs.org,
       ray-lk@madrabbit.org, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       iggy@gentoo.org
Subject: Re: [RFC][PATCH] inotify 0.10.0
References: <1096250524.18505.2.camel@vertex>	<20040926211758.5566d48a.akpm@osdl.org>	<1096318369.30503.136.camel@betsy.boston.ximian.com>	<1096350328.26742.52.camel@orca.madrabbit.org>	<20040928120830.7c5c10be.akpm@osdl.org>	<41599456.6040102@nortelnetworks.com>	<1096390398.4911.30.camel@betsy.boston.ximian.com>	<1096392771.26742.96.camel@orca.madrabbit.org>	<1096403685.30123.14.camel@vertex>	<20040929211533.5e62988a.akpm@osdl.org>	<1096508073.16832.17.camel@localhost> <20040929200525.4e7bb489.pj@sgi.com>
In-Reply-To: <20040929200525.4e7bb489.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Robert wrote:
> 
>>A monitor on "/etc" will return "hosts" if hosts is modified.  Which I
>>think is OK--we don't pass the entire path, nor do we want to if we
>>could do it easily, for numerous reasons ..
> 
> 
> How about returning the inode number?

Then I think you need the filesystem as well.

Chris

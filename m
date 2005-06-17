Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVFQQo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVFQQo0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 12:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVFQQo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 12:44:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262017AbVFQQoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 12:44:23 -0400
Date: Fri, 17 Jun 2005 09:43:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Valdis.Kletnieks@vt.edu, Robert Love <rml@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] inotify, improved.
Message-ID: <20050617164351.GI9153@shell0.pdx.osdl.net>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au> <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy> <42B2EE31.9060709@nortel.com> <1119023078.3949.115.camel@betsy> <200506171611.j5HGBFY8012609@turing-police.cc.vt.edu> <42B2FBF3.6010607@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B2FBF3.6010607@nortel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Friesen (cfriesen@nortel.com) wrote:
> Valdis.Kletnieks@vt.edu wrote:
> 
> >It's also racy as hell.  By the time the inotify gets delivered to the
> >userspace process, pid 820 may be long gone.....
> 
> Yep.  But I can see uses for people to want to log all activity on 
> specific directory trees.  Think audit trails, etc.

This is already done by the audit patch.  I don't think inotify has
quite enough info to build a comprehensive audit record.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVHGHJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVHGHJC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 03:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVHGHJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 03:09:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751160AbVHGHJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 03:09:02 -0400
Date: Sun, 7 Aug 2005 00:08:40 -0700
From: Chris Wright <chrisw@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chris Wright <chrisw@osdl.org>, Zachary Amsden <zach@vmware.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       Riley@Williams.Name, pratap@vmware.com, chrisl@vmware.com
Subject: Re: [PATCH 1/8] Move MSR accessors into the sub-arch layer
Message-ID: <20050807070840.GO7762@shell0.pdx.osdl.net>
References: <42F4626D.1000401@vmware.com> <20050807010247.GF7762@shell0.pdx.osdl.net> <42F57104.5090208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F57104.5090208@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Peter Anvin (hpa@zytor.com) wrote:
> I would like to strongly request one addition, however: please make it 
> so that a subarchitecture which is still a hardware architecture doesn't 
> have to redefine all of these every time.

Yep, that's done.  As long as the defaults are ok, the subarch doesn't
need to override them.  So I think that request is met.

thanks,
-chris

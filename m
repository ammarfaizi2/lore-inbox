Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUDUA01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUDUA01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbUDUA01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:26:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:13742 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264514AbUDUA0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:26:24 -0400
Date: Tue, 20 Apr 2004 17:26:22 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zack Brown <zbrown@tumblerings.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: matching "Cset exclude" changelog entries to the changelog entries they revert.
Message-ID: <20040420172622.K22989@build.pdx.osdl.net>
References: <20040421001236.GA16901@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040421001236.GA16901@tumblerings.org>; from zbrown@tumblerings.org on Tue, Apr 20, 2004 at 05:12:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zack Brown (zbrown@tumblerings.org) wrote:
> for instance, "Cset exclude: davej@suse.de|ChangeSet|20020403195622" is in
> 2.5.8-pre2, as the full text of the changelog entry.

bk prs -r"davej@suse.de|ChangeSet|20020403195622" -hnd:REV: ChangeSet

That will give you the rev from that key in the Cset exclude message.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

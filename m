Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTFBQXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 12:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTFBQXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 12:23:42 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:53742 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S263791AbTFBQXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 12:23:41 -0400
Date: Mon, 2 Jun 2003 09:33:57 -0700
From: Chris Wright <chris@wirex.com>
To: Andrew Morton <akpm@digeo.com>
Cc: gj@pointblue.com.pl, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com, greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Early init for security modules and various cleanups
Message-ID: <20030602093356.K27233@figure1.int.wirex.com>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>, gj@pointblue.com.pl,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com, greg@kroah.com, sds@epoch.ncsc.mil
References: <20030602025450.C27233@figure1.int.wirex.com> <Pine.LNX.4.44.0306021205520.27640-100000@pointblue.com.pl> <20030602030946.H27233@figure1.int.wirex.com> <20030602034419.3776d3b7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030602034419.3776d3b7.akpm@digeo.com>; from akpm@digeo.com on Mon, Jun 02, 2003 at 03:44:19AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@digeo.com) wrote:
> Chris Wright <chris@wirex.com> wrote:
> >
> > security_capable() returns 0 if that capability bit is set. 
> 
> That's just bizarre.  Is there any logic behind it?

Yes, as Stephen pointed out, it's common for the security interface to
return 0 on success on -errno on failure.

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

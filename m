Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbUDAV51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUDAVXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:23:40 -0500
Received: from holomorphy.com ([207.189.100.168]:49839 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263177AbUDAVNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:13:37 -0500
Date: Thu, 1 Apr 2004 13:13:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       kenneth.w.chen@intel.com, Chris Wright <chrisw@osdl.org>
Subject: Re: disable-cap-mlock
Message-ID: <20040401211326.GM791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	kenneth.w.chen@intel.com, Chris Wright <chrisw@osdl.org>
References: <20040401135920.GF18585@dualathlon.random> <1080845238.25431.196.camel@moss-spartans.epoch.ncsc.mil> <20040401192612.GL791@holomorphy.com> <200404012223.07871@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404012223.07871@WOLK>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 April 2004 21:26, William Lee Irwin III wrote:
>> Okay, done.
>> Misc fix thrown in: the policies beyond enabled/disabled were wrongly
>> set up in minmax' args, so this throws the real max in the table.

On Thu, Apr 01, 2004 at 10:23:07PM +0200, Marc-Christian Petersen wrote:
> Great. Works :) ... Prolly the attached one ontop.
> ciao, Marc

I folded that into my little series, but they'll probably all get
globbed together for archival in the end anyway.

Not sure where this is all going. I guess if someone's got a use for it
or otherwise it's a useful example of how to do a security module,
maybe writing it did some good after all.


-- wli

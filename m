Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUEFRGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUEFRGy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUEFRGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:06:54 -0400
Received: from nodns-212-69-243-51.first4it.co.uk ([212.69.243.51]:25101 "HELO
	linuxoutlaws.co.uk") by vger.kernel.org with SMTP id S261468AbUEFRGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:06:49 -0400
Date: Thu, 6 May 2004 18:00:56 +0100
From: Rob Shakir <rob@rshk.co.uk>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/ext3/balloc.c:942!
Message-ID: <20040506170056.GA12754@rshk.co.uk>
References: <Pine.LNX.4.58.0405051729140.2284@montezuma.fsmlabs.com> <20040505222408.GA10030@rshk.co.uk> <1083846724.11249.16.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083846724.11249.16.camel@watt.suse.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 08:32:04AM -0400, Chris Mason wrote:
> There was an additional error message from reiserfs before the bug,
> could you please look for it in your logs?

The messages preceding the bug in the logs were:

5140
0: file_release
1: reiserfs_vfs_truncate_file
PAP-5140: search_by_key: schedule occurred in do_balance!------------[ cut here ]------------

I apologise for not adding those in the initial bug report. 

> 
> Looks like you're on 2.6.5, the reiserfs logging fixes in 2.6.6-rc2 and
> higher fix a few different ways you can oops in search_by_key.
> 

Thanks, I'll try that and see if it fixes the problem.

Rob

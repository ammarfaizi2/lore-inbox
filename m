Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUEFMbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUEFMbi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUEFMbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:31:37 -0400
Received: from ns.suse.de ([195.135.220.2]:11181 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262101AbUEFMbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:31:10 -0400
Subject: Re: kernel BUG at fs/ext3/balloc.c:942!
From: Chris Mason <mason@suse.com>
To: Rob Shakir <rob@rshk.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040505222408.GA10030@rshk.co.uk>
References: <Pine.LNX.4.58.0405051729140.2284@montezuma.fsmlabs.com>
	 <20040505222408.GA10030@rshk.co.uk>
Content-Type: text/plain
Message-Id: <1083846724.11249.16.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 08:32:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-05 at 18:24, Rob Shakir wrote:
> I've seen something vaguely similar to this problem, but rather than running 
> ext3 I'm running ReiserFS. 
> 
> This problem has occured twice, but I've just got the machine back running to
> report the bug properly.
> 
There was an additional error message from reiserfs before the bug,
could you please look for it in your logs?

Looks like you're on 2.6.5, the reiserfs logging fixes in 2.6.6-rc2 and
higher fix a few different ways you can oops in search_by_key.

-chris



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTHZJp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 05:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbTHZJp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 05:45:26 -0400
Received: from holomorphy.com ([66.224.33.161]:24238 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263572AbTHZJpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 05:45:24 -0400
Date: Tue, 26 Aug 2003 02:46:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030826094634.GP4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <20030821234709.GD1040@matchmail.com> <AC36AB3038685indou.takao@soft.fujitsu.com> <20030825041117.GN4306@holomorphy.com> <20030825225847.GA16831@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825225847.GA16831@matchmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 09:11:17PM -0700, William Lee Irwin III wrote:
>> This is moderately misguided; essentially the only way userspace can
>> utilize RAM at all is via the pagecache. It's not useful to limit this;
>> you probably need inode-highmem or some such nonsense.

On Mon, Aug 25, 2003 at 03:58:47PM -0700, Mike Fedyk wrote:
> Exactly.  Every program you have opened, and all of its libraries will show
> up as pagecache memory also, so seeing a large pagecache in and of itself
> may not be a problem.
> Let's get past the tuning paramenter you want in /proc, and tell us more
> about what you are doing that is causing this problem to be shown.

One thing I thought of after the post was whether they actually had in
mind tunable hard limits on _unmapped_ pagecache, which is, in fact,
useful. OTOH that's largely speculation and we really need them to
articulate the true nature of their problem.


-- wli

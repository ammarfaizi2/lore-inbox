Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268285AbUJOUlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268285AbUJOUlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268344AbUJOUlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 16:41:36 -0400
Received: from holomorphy.com ([207.189.100.168]:8845 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268285AbUJOUlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 16:41:32 -0400
Date: Fri, 15 Oct 2004 13:41:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Albert Cahalan <albert@users.sf.net>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015204123.GP5607@holomorphy.com>
References: <1097846353.2674.13298.camel@cube> <20041015162000.GB17849@dualathlon.random> <1097857912.2669.13548.camel@cube> <20041015171355.GD17849@dualathlon.random> <1097862714.2666.13650.camel@cube> <20041015181446.GF17849@dualathlon.random> <20041015183025.GN5607@holomorphy.com> <20041015184009.GG17849@dualathlon.random> <20041015184713.GO5607@holomorphy.com> <20041015192313.GH17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041015192313.GH17849@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:47:13AM -0700, William Lee Irwin III wrote:
>> workloads, rather it's known up-front that no fork()-based COW sharing
>> is going on in Oracle's case, so in this case, "anonymous" very happily
>> corresponds to "process-private". [..]

On Fri, Oct 15, 2004 at 09:23:13PM +0200, Andrea Arcangeli wrote:
> Ok fine.

On Fri, Oct 15, 2004 at 11:47:13AM -0700, William Lee Irwin III wrote:
>> [..] In fact, the /proc/ changes to report
>> threads only under the directory hierarchy of some distinguished thread
>> assists in this estimation effort.

On Fri, Oct 15, 2004 at 09:23:13PM +0200, Andrea Arcangeli wrote:
> do you use threads now?

I believe using threads to some extent has been an option for some time,
though not a commonly used one on Linux.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbTEQBSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 21:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264645AbTEQBSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 21:18:48 -0400
Received: from holomorphy.com ([66.224.33.161]:62937 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264643AbTEQBSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 21:18:47 -0400
Date: Fri, 16 May 2003 18:31:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix, v4
Message-ID: <20030517013132.GY8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030516161717.1e629364.akpm@digeo.com> <20030516161753.08470617.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516161753.08470617.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 04:17:53PM -0700, Andrew Morton wrote:
> - There's a vmalloc race.  David Woodhouse has a patch, but it had a
>   problem.  Need to revisit it.

dwmw2 and I conferred and it turned out our patches were for the same
issue (resolved, fix in 2.5.69-bk). Either he or I will do a direct
comparison soon to make sure all cases covered by dwmw2's patch are
covered in mainline.


-- wli

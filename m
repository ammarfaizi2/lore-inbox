Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265342AbUEZHzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbUEZHzW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUEZHzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:55:21 -0400
Received: from holomorphy.com ([207.189.100.168]:31125 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265342AbUEZHzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:55:18 -0400
Date: Wed, 26 May 2004 00:55:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Buddy Lumpkin <b.lumpkin@comcast.net>
Cc: orders@nodivisions.com, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Message-ID: <20040526075506.GV1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Buddy Lumpkin <b.lumpkin@comcast.net>, orders@nodivisions.com,
	linux-kernel@vger.kernel.org
References: <40B43B5F.8070208@nodivisions.com> <S265327AbUEZH12/20040526072728Z+1185@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S265327AbUEZH12/20040526072728Z+1185@vger.kernel.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 12:31:16AM -0700, Buddy Lumpkin wrote:
> This is a really good point. I think the bar should be set at max
> performance for systems that never need to use the swap device. 
> If someone wants to tune swap performance to their hearts content, so be it.
> But given cheap prices for memory, and the horrible best case performance
> for swap, an increase in swap performance should never, ever come at the
> expense of performance for a system that has been sized such that executable
> address spaces, libraries and anonymous memory will fit easily within
> physical ram.
> This of course doesn't address the VM paging storms that happen due to large
> amounts of file system writes. Once the pagecache fills up, dirty pages must
> be evicted from the pagecache so that new pages can be added to the
> pagecache.

If you've got a real performance issue, please describe it properly
instead of asserting without evidence the existence of one.


-- wli

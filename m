Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUFBSxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUFBSxC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUFBSxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:53:02 -0400
Received: from holomorphy.com ([207.189.100.168]:39577 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263824AbUFBSwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:52:14 -0400
Date: Wed, 2 Jun 2004 11:52:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       suparna@in.ibm.com, linux-aio@kvack.org
Subject: Re: [1/2] use const in time.h unit conversion functions
Message-ID: <20040602185205.GX21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, suparna@in.ibm.com,
	linux-aio@kvack.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602012429.GV2093@holomorphy.com> <20040602184335.GC5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602184335.GC5414@waste.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 01:43:35PM -0500, Matt Mackall wrote:
> This is the second const-correctness patch I've seen in a couple days,
> and I'd like to point out that while it's a noble cause, retrofitting
> const decls onto interfaces is notorious for causing ripple effects in
> APIs.

There's a point to this one. A warning got tripped when const stuff was
passed to it in patch #2, hence this as a preparatory cleanup.


-- wli

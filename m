Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUF1IUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUF1IUW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 04:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbUF1IUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 04:20:22 -0400
Received: from holomorphy.com ([207.189.100.168]:15264 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264886AbUF1IUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 04:20:19 -0400
Date: Mon, 28 Jun 2004 01:20:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@oss.sgi.com, davem@redhat.com
Subject: Re: kiocb->private is too large for kiocb's on-stack
Message-ID: <20040628082016.GP21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com
References: <20040628080801.GO21066@holomorphy.com> <20040628011232.43acd3b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040628011232.43acd3b8.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 01:12:32AM -0700, Andrew Morton wrote:
> That's so much better than what we had before it ain't funny.
> Was this runtime tested?

Yes. Oracle exercises this, and it survives OAST.

I'll write a dedicated userspace testcase for the aio operations and
follow up with that.


-- wli

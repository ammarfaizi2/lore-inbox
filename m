Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265885AbUAKN7w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUAKN6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:58:13 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5894 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265882AbUAKN55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:57:57 -0500
Date: Sun, 11 Jan 2004 13:57:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: personality.h: struct map_segment
Message-ID: <20040111135755.A21901@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Justin Pryzby <justinpryzby@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20040111015723.GA8968@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040111015723.GA8968@andromeda>; from justinpryzby@users.sourceforge.net on Sat, Jan 10, 2004 at 08:57:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 08:57:24PM -0500, Justin Pryzby wrote:
> However, as best as I can tell, struct map_segment is never defined.
> I've grepped 2.4 and 2.5, and googled to no avail.  I'm just curious, is
> this simply unimplemented functionality?  And what is it ultimately
> supposed to do?

It's used in the linux-abi modules to map between constants of foreign
OSes to the Linux native ones, e.g. for error numbers, signal numbers
and whatever.  It probably does not have much business beeing in mainline
personality.h..


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269112AbUINCJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269112AbUINCJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUINCH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:07:56 -0400
Received: from holomorphy.com ([207.189.100.168]:54671 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269111AbUINCEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:04:00 -0400
Date: Mon, 13 Sep 2004 19:03:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: fake_ino fixes
Message-ID: <20040914020355.GG9106@holomorphy.com>
References: <1095090739.2191.1465.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095090739.2191.1465.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 11:52:19AM -0400, Albert Cahalan wrote:
> This improves /proc inode numbering a bit.
> If ino_t is 32-bit: just fix task 0 handling
> If ino_t is 64-bit: fix large fd numbers too
> Handling PID 0xffff on 32-bit was dropped in
> favor of handling PID 0 correctly, since PID 0
> can be seen with the default pid_max value.

Sounds like a good stopgap measure unless someone's already got a more
comprehensive sweep that enables larger pid spaces on 32-bit.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbTJMCE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 22:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbTJMCE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 22:04:56 -0400
Received: from holomorphy.com ([66.224.33.161]:18564 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261342AbTJMCEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 22:04:55 -0400
Date: Sun, 12 Oct 2003 19:08:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] report user-readable fixmap area in /proc/PID/maps
Message-ID: <20031013020803.GE16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
	mingo@redhat.com, linux-kernel@vger.kernel.org
References: <200310130135.h9D1Zajj008309@magilla.sf.frob.com> <Pine.LNX.4.44.0310121845100.12190-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310121845100.12190-100000@home.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 06:49:56PM -0700, Linus Torvalds wrote:
> don't get yet another (unnecessary) allocation on fork time. I hate how
> fork()  has slowed down due to other issues (mainly rmap).

Lighter-weight data structure arrangments for ptov resolution than have
been available for some time, e.g. since 2.5.65 or so.


-- wli

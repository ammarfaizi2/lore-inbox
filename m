Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTAFSlt>; Mon, 6 Jan 2003 13:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbTAFSlt>; Mon, 6 Jan 2003 13:41:49 -0500
Received: from ip68-0-152-218.tc.ph.cox.net ([68.0.152.218]:2951 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S267091AbTAFSlt>; Mon, 6 Jan 2003 13:41:49 -0500
Date: Mon, 6 Jan 2003 11:50:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] configurable LOG_BUF_SIZE
Message-ID: <20030106185025.GC796@opus.bloom.county>
References: <Pine.LNX.4.33L2.0301021501580.22868-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301021501580.22868-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 03:09:17PM -0800, Randy.Dunlap wrote:

> This patch to 2.5.54 make LOG_BUF_LEN a configurable option.
> Actually its shift value is configurable, and that keeps it
> a power of 2.

Erm, why not just prompt for an int, slightly change the help wording,
and then just give a default int value directly.

Flexibility is good for everyone.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

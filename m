Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUIEARK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUIEARK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 20:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUIEARJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 20:17:09 -0400
Received: from holomorphy.com ([207.189.100.168]:44686 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264973AbUIEARG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 20:17:06 -0400
Date: Sat, 4 Sep 2004 17:16:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040905001653.GA3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	linux-kernel@vger.kernel.org
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904153902.6ac075ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904153902.6ac075ea.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 03:39:02PM -0700, Andrew Morton wrote:
> I don't know how much of a problem this is in practice - there are all
> sorts of nasty things which unprivileged apps can do to the system by
> overloading filesystems.  Although most of them can be killed off by the
> sysadmin.
> (My infamous bash-shared-mappings stresstest can spend ten or more minutes
> within a single write() call, but you have to try hard to do this).

This reminds me; I'm having a chicken and egg problem with several
stresstests I've written but withheld until fixes for the crashes they
trigger are available, but the fixes appear to be hard enough to arrange
they need public commentary to find acceptable methods of addressing
them. What's the recommended procedure for all this?


-- wli

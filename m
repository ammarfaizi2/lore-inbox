Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271183AbTHCUxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271007AbTHCUxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:53:23 -0400
Received: from home.wiggy.net ([213.84.101.140]:60545 "EHLO
	thunder.home.wiggy.net") by vger.kernel.org with ESMTP
	id S270855AbTHCUxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:53:13 -0400
Date: Sun, 3 Aug 2003 22:52:51 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, devik@cdi.cz
Subject: Re: [PATCH] Allow /dev/{,k}mem to be disabled to prevent kernel from being modified easily
Message-ID: <20030803205251.GA2225@wiggy.net>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, devik@cdi.cz
References: <20030803180950.GA11575@outpost.ds9a.nl> <20030803123218.7bb2c16f.akpm@osdl.org> <20030803204515.GA15271@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803204515.GA15271@outpost.ds9a.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously bert hubert wrote:
> problem with sigsegv is that it does not allow legitimate programs to choose
> an alternate approach - the log entry would be nice though.

Is that likely to happen on the kind of machines on which you will use
this option?

Also, if your purpose is to prevent userland from meddling with memory
you might want to block iopl was well.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.


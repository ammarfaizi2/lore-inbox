Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUFRCBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUFRCBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 22:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbUFRCBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 22:01:01 -0400
Received: from cantor.suse.de ([195.135.220.2]:32648 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264928AbUFRCAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 22:00:52 -0400
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
	mapping
From: Chris Mason <mason@suse.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1087523668.8002.103.camel@watt.suse.com>
References: <1087523668.8002.103.camel@watt.suse.com>
Content-Type: text/plain
Message-Id: <1087524095.8002.105.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 17 Jun 2004 22:01:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 21:54, Chris Mason wrote:

> Here's an example patch that should fix things, Andi just found
> a race where I wasn't holding onto the filesystem inode correctly,
> so this rev got a last minute fix before I wander off for the night.

Ugh, this oopses on boot.  I'll provide a better example patch tomorrow
unless someone comes up with something clean over night ;-)

-chris



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265470AbSKVX5T>; Fri, 22 Nov 2002 18:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSKVX5T>; Fri, 22 Nov 2002 18:57:19 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:15249 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265470AbSKVX5T>;
	Fri, 22 Nov 2002 18:57:19 -0500
Date: Sat, 23 Nov 2002 00:06:17 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: David Schwartz <davids@webmaster.com>
Cc: gianni@ecsc.co.uk, linux-kernel@vger.kernel.org
Subject: Re: TCP memory pressure question
Message-ID: <20021123000616.GB19162@bjl1.asuk.net>
References: <1037966789.6079.33.camel@lemsip> <20021122202855.AAA322@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021122202855.AAA322@shell.webmaster.com@whenever>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	So this would be a case where 'poll' or 'select' would return
> a write hit for a socket but 'write' would return -1 and set errno
> to EAGAIN.

Is this really true?  It would livelock several servers I've worked on...

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUDMDeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 23:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUDMDeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 23:34:07 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:34766 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263154AbUDMDeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 23:34:05 -0400
Subject: Re: [PATCH] eliminate nswap and cnswap
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton OSDL <akpm@osdl.org>, mpm@selenic.com
Content-Type: text/plain
Organization: 
Message-Id: <1081827102.1593.227.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Apr 2004 23:31:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The nswap and cnswap variables counters have never
> been incremented as Linux doesn't do task swapping.

I'm pretty sure they were used for paging activity.
We don't eliminate support for "swap space", do we?

Somebody must have broken nswap and cnswap while
hacking on some vm code. I hate to see the variables
get completely ripped out of the kernel instead of
getting fixed.





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUB2IsG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 03:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUB2IsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 03:48:06 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6410 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262017AbUB2IsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 03:48:04 -0500
Date: Sun, 29 Feb 2004 09:38:22 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Rus Foster <rghf@fsck.me.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24/2.4.25 security diff
Message-ID: <20040229083822.GD7785@alpha.home.local>
References: <Pine.LNX.4.58.0402281506540.18838@bitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402281506540.18838@bitch.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 03:07:51PM +0000, Rus Foster wrote:
> Hi All,
>  Does anyone have just a small diff so that I can backport the 2.4.25
> security fix to 2.4.24?

You need James Bourne's -uv patches, available at the following location :

  http://www.hardrock.org/kernel/2.4.24-updates/

He's done all the boring work of backporting only critical fixes.
There's also http://toxygen.net/hotfixes/ which provides loadable modules
to fix the security bugs without even rebooting your servers.

Regards,
Willy


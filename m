Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTKXSIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTKXSIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:08:41 -0500
Received: from sigint.cs.purdue.edu ([128.10.2.82]:32130 "EHLO
	sigint.cs.purdue.edu") by vger.kernel.org with ESMTP
	id S262674AbTKXSIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:08:39 -0500
Date: Mon, 24 Nov 2003 13:08:38 -0500
From: splite@purdue.edu
To: Jakob Lell <jlell@JakobLell.de>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031124180838.GA8065@sigint.cs.purdue.edu>
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos> <200311241857.41324.jlell@JakobLell.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311241857.41324.jlell@JakobLell.de>
X-Disclaimer: Any similarity to an opinion of Purdue is purely coincidental
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 06:57:41PM +0100, Jakob Lell wrote:
> [...]
> Setuid-root binaries also work in a home directory.
> You can try it by doing this test:
> ln /bin/ping $HOME/ping
> $HOME/ping localhost
> [...]

That's why you don't put user-writable directories on the root or /usr
partitions.  (For extra points, mount your /tmp and /var/tmp partitions
nodev,nosuid.)  Seriously guys, this is Unix Admin 101, not a major new
security problem.

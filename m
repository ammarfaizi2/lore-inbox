Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTKXSLK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTKXSLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:11:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13699 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262360AbTKXSLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:11:07 -0500
Date: Mon, 24 Nov 2003 13:13:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: splite@purdue.edu
cc: Jakob Lell <jlell@JakobLell.de>, linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
In-Reply-To: <20031124180838.GA8065@sigint.cs.purdue.edu>
Message-ID: <Pine.LNX.4.53.0311241312180.18685@chaos>
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos>
 <200311241857.41324.jlell@JakobLell.de> <20031124180838.GA8065@sigint.cs.purdue.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003 splite@purdue.edu wrote:

> On Mon, Nov 24, 2003 at 06:57:41PM +0100, Jakob Lell wrote:
> > [...]
> > Setuid-root binaries also work in a home directory.
> > You can try it by doing this test:
> > ln /bin/ping $HOME/ping
> > $HOME/ping localhost
> > [...]
>
> That's why you don't put user-writable directories on the root or /usr
> partitions.  (For extra points, mount your /tmp and /var/tmp partitions
> nodev,nosuid.)  Seriously guys, this is Unix Admin 101, not a major new
> security problem.
>

And if the inode that was referenced in the root-owned directory
was deleted, it would no longer function as setuid root.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



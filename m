Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUJDOAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUJDOAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267449AbUJDN76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:59:58 -0400
Received: from web1.mmaero.com ([67.98.186.98]:6560 "EHLO web1.mmaero.com")
	by vger.kernel.org with ESMTP id S267556AbUJDN7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:59:33 -0400
Date: Mon, 4 Oct 2004 09:59:28 -0400 (EDT)
From: Jon Lewis <jlewis@lewis.org>
X-X-Sender: jlewis@web1.mmaero.com
To: William Knop <wknop@andrew.cmu.edu>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: libata badness
In-Reply-To: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
Message-ID: <Pine.LNX.4.58.0410040953160.26615@web1.mmaero.com>
References: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2004, William Knop wrote:

> Hi all,
>
> I'm running a raid5 array atop a few sata drives via a promise tx4
> controller. The kernel is the official fedora lk 2.6.8-1, although I had
> run a few different kernels (never entirely successfully) with this array
> in the past.

What kind of sata drives?  It's not quite the same end result, but there
have been several posts on linux-raid about defective Maxtor sata drives
causing system freezes.  If your drives are Maxtor, download their
powermax utility and test your drives.  You may find that you have one or
more marginal drives that appear to work most of the time, but powermax
will determine are bad.  Replacing one like that fixed my problems.

----------------------------------------------------------------------
 Jon Lewis                   |  I route
 Senior Network Engineer     |  therefore you are
 Atlantic Net                |
_________ http://www.lewis.org/~jlewis/pgp for PGP public key_________

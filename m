Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbTL0VQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 16:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbTL0VQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 16:16:22 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:235 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264568AbTL0VQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 16:16:21 -0500
Date: Sat, 27 Dec 2003 22:13:24 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Paul <paul@kbs.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: memory mapping help - oracle stack dumps
Message-ID: <20031227221324.A21421@electric-eye.fr.zoreil.com>
References: <E1AYl4w-0007A5-R3@O.Q.NET> <Pine.LNX.4.44.0312240005180.4342-100000@raven.themaw.net> <20031223173429.GA9032@mark.mielke.cc> <20031223220209.GB15946@kroah.com> <1072226715.6917.50.camel@nosferatu.lan> <20031224010728.GA20956@kroah.com> <03b201c3c9bc$5d977ef0$7301a8c0@internal.kbs.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <03b201c3c9bc$5d977ef0$7301a8c0@internal.kbs.net.au>; from paul@kbs.net.au on Wed, Dec 24, 2003 at 12:22:13PM +1100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul <paul@kbs.net.au> :
[oracle9i listener crashing]

Run memtest on your computer. If you do not see any error (ECC support is
enabled in your hardware setup, is not it ?), ask oracle to fix the bug.

Segfault in chunk_free() _usually_ means double free/use after free or so.
So far, this does not really look like a kernel related problem.

--
Ueimor

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273004AbTHKSiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273002AbTHKShE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:37:04 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:34945 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S272956AbTHKSfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:35:54 -0400
Date: Mon, 11 Aug 2003 14:33:50 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 VGA console inevitable?
In-Reply-To: <20030809154340.GB5396@www.13thfloor.at>
Message-ID: <Pine.GSO.4.33.0308111431210.7750-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Herbert [iso-8859-1] Pötzl wrote:
>ahh got it, one has to select
> ->  Remove kernel features (for embedded systems)
>
>then VT/VGA_CONSOLE can be removed ...

Yes, that is an "idiot proofing" change for 2.6 so people don't accidentally
turn off the video and keyboard -- as will happen if a 2.4 .config is used
in 2.6.

(It took me a minute to realize why the options for turning off input weren't
 avaliable... on sparc64 no less.)

--Ricky



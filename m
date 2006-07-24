Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWGXRfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWGXRfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWGXRfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:35:32 -0400
Received: from mail.gmx.de ([213.165.64.21]:2512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932173AbWGXRfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:35:32 -0400
X-Authenticated: #428038
Message-ID: <44C504DC.6080907@gmx.de>
Date: Mon, 24 Jul 2006 19:35:24 +0200
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Benoit <ipso@snappymail.ca>
CC: Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <44C28A8F.1050408@garzik.org>	 <44C32348.8020704@namesys.com> <200607230212.55293.lkml@lpbproductions.com>	 <44C44622.9050504@namesys.com>	 <20060724085455.GD24299@merlin.emma.line.org>	 <44C4813E.2030907@namesys.com>	 <20060724102508.GA26553@merlin.emma.line.org> <1153760245.5735.47.camel@ipso.snappymail.ca>
In-Reply-To: <1153760245.5735.47.camel@ipso.snappymail.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Benoit wrote:

> I've been bitten by running out of inodes on several occasions, and by
> switching to ReiserFS it saved one company I worked for over $250,000
> because they didn't need to buy a totally new piece of software.

ext3fs's inode density is configurable, reiserfs's hash overflow chain
length is not, and it doesn't show in df -i either.

If you need lots of inodes, mkfs for lots. That's old Unix lore.

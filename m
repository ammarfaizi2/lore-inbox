Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266215AbUBDBBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUBDBBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:01:19 -0500
Received: from www.trustcorps.com ([213.165.226.2]:50193 "EHLO raq1.nitrex.net")
	by vger.kernel.org with ESMTP id S266215AbUBDBBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:01:16 -0500
Message-ID: <402043C9.8000703@hcunix.net>
Date: Wed, 04 Feb 2004 00:58:49 +0000
From: the grugq <grugq@hcunix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <4017E3B9.3090605@hcunix.net> <20040203222030.GB465@elf.ucw.cz> <40203DE1.3000302@hcunix.net> <20040204004318.GA253@elf.ucw.cz> <4020416B.3050301@hcunix.net> <20040204005514.GB253@elf.ucw.cz>
In-Reply-To: <20040204005514.GB253@elf.ucw.cz>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

> 
> [Perhaps I got confused somewhere in between]

nope, just me.

> 
> I think chattr +s file should be zeroed, along with its metadata. I
> thought your patch already does that. If not, doing that would be
> great...

it does already zero the meta-data. I was simply asking if you think the 
whole "erase" operation should be under the control of chattr 's', or 
just a subset (i.e. only data overwriting is optional). Its clear now 
that you want the whole thing to be controled by chattr 's'. I'll knock 
that up then, and re-submit.


peace,

--gq

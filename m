Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWEFW03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWEFW03 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 18:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWEFW03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 18:26:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932094AbWEFW01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 18:26:27 -0400
Date: Sat, 6 May 2006 15:26:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: minixfs bitmaps and associated lossage
In-Reply-To: <20060506220451.GQ27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0605061524420.16343@g5.osdl.org>
References: <44560796.8010700@gmail.com> <20060506162956.GO27946@ftp.linux.org.uk>
 <20060506163737.GP27946@ftp.linux.org.uk> <20060506220451.GQ27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 May 2006, Al Viro wrote:
>
> 	Warning: text below is a mild example of software coproarchaeology,
> so if you are easily squicked by tangled mess of bugs and dumb lossage,
> well... you've been warned.

LOL.

Maybe the right thing to do is to just disable minixfs for anything 
big-endian except for m68k.

It's not like it likely matters, and while we could save your description 
of the problem as an amusing "how to really f*ck up" episode, I doubt 
anybody really _cares_ in this case.

			Linus

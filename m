Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbTEFPqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTEFPqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:46:30 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:15751 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S263892AbTEFPq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:46:29 -0400
Message-ID: <3EB7DBC0.40907@comcast.net>
Date: Tue, 06 May 2003 08:58:56 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030504
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tmb@iki.fi, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a problem with this, ...
> If we calculate the exact memory like this, there wont be any
> memory remapped to do double/tripple buffering...
> So the question is: shoud one take the formula and add ' * 2' to
> atleast get the double buffering supported...
> (in the patch I made for mdk, I kept a modified override part so that
> the user can change this, if he needs it....)

Hello.  I realize that there won't be enough memory for double/triple
buffering using my patch. I even thought of doing the *2 thing, but
decided against it. The idea I had is that more and more video cards are
coming out with 128+ MB Ram, and that machines with >=1GB Ram are also
becoming common, especially for gamers etc...  Those users, I believe,
are less likely to use vesafb for anything other than graphics boot
splash and this just removes one little out-of-the-box problem many have
been having. I thought it to be a safer default than attempting to
ioremap the entire framebuffer. Just my thoughts,

-Walt Holman




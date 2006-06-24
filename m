Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932825AbWFXFX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbWFXFX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 01:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbWFXFX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 01:23:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:912 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932825AbWFXFX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 01:23:58 -0400
Message-ID: <449CCBA1.9020904@zytor.com>
Date: Fri, 23 Jun 2006 22:20:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com, ak@muc.de, akpm@osdl.org
Subject: Re: i386 ABI and the stack
References: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>	 <Pine.LNX.4.64.0606231844460.6483@g5.osdl.org>	 <449C9C6D.7050905@zytor.com>	 <Pine.LNX.4.64.0606231907290.6483@g5.osdl.org> <787b0d920606231943x7aad43bwb108b6a88b678b1a@mail.gmail.com>
In-Reply-To: <787b0d920606231943x7aad43bwb108b6a88b678b1a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> Since gcc-2.96 would access 256 bytes below the stack pointer
> (according to the valgrind man page), the kernel needs to allow
> for this in signal handlers anyway.
> 
> I'm pretty sure I saw that code in the kernel in fact, but I
> can't find it now. Perhaps it got lost in a cleanup accident?
> (it sure would be nice to have continuous source control history)

We have it; you can graft on the pre-git history.  See previous posts on 
this and the git list.

	-hpa


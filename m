Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281928AbRKURTB>; Wed, 21 Nov 2001 12:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281927AbRKURSv>; Wed, 21 Nov 2001 12:18:51 -0500
Received: from [195.63.194.11] ([195.63.194.11]:44306 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281917AbRKURSl>; Wed, 21 Nov 2001 12:18:41 -0500
Message-ID: <3BFBDFA5.DDA1CC98@evision-ventures.com>
Date: Wed, 21 Nov 2001 18:08:53 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ado.Arnolds@dhm-systems.de
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: fs/exec.c and binfmt-xxx in 2.4.14
In-Reply-To: <3BFBDD32.434AB47B@web-systems.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinz-Ado Arnolds wrote:
> 
> Hi Linus, Hi Alan, Hi all,
> 
> I have a problem with loading modules for binary formats. The
> reason for this problem shows up in fs/exec.c search_binary_handler().
> 
> Starting with linux-2.1.23 (and up to 2.4.14) there was a change
> in the format and offset of printing the magic number for requesting
> a handler module. Up to 2.1.22 the statement

That is a time span of several years during which nobody realized
there was a problem with this. Therefore I would rather
request for removal of the whole binfmt-misc stuff (which is ugly
anyway)
rather then "fixing it" ;-)

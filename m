Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311879AbSDBAvU>; Mon, 1 Apr 2002 19:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312532AbSDBAvJ>; Mon, 1 Apr 2002 19:51:09 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:51149 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S311879AbSDBAu6>; Mon, 1 Apr 2002 19:50:58 -0500
Date: Mon, 1 Apr 2002 16:51:16 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Questions about /proc/stat
In-Reply-To: <Pine.LNX.4.33L2.0204011556100.13412-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0204011649050.9748-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Randy.Dunlap wrote:

> On Mon, 1 Apr 2002, M. Edward (Ed) Borasky wrote:
>
> | On Mon, 1 Apr 2002, Randy.Dunlap wrote:
> |
> | > Of course the basic answer is something like
> | >   Try cscope
> |
> | I can't find this -- does it come with Red Hat??
>
> it's at cscope.sf.net

OK ... I'll go grab it.

> | Ah ... so every page to/from swap is counted in pswpin/out (as a page)
> | and again in pgpgin/out as half-kilobytes :-). Incidentally, I also
> | followed the third fork in this road, the one which derives the "blocks"
> | read and written per device that show up in /proc/stat. Those "blocks"
> | turn out to be 512 bytes long.
>
> Do you mean this line or something else?
>   disk_io: (3,0):(616296,386142,7120356,230154,3010882)

Yeah ... that one. I have code that samples that every 15 seconds, as
well as everything else in /proc/stat. I was having trouble making sense
of the I/O numbers.

Q. How do you tell when a pineapple is ready to eat?
A. It picks up its knife and fork.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291767AbSBNQ0x>; Thu, 14 Feb 2002 11:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291773AbSBNQ0o>; Thu, 14 Feb 2002 11:26:44 -0500
Received: from angband.namesys.com ([212.16.7.85]:39041 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291767AbSBNQ0e>; Thu, 14 Feb 2002 11:26:34 -0500
Date: Thu, 14 Feb 2002 19:26:33 +0300
From: Oleg Drokin <green@namesys.com>
To: Sebastian =?koi8-r?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs Corruption with 2.5.5-pre1
Message-ID: <20020214192633.A2311@namesys.com>
In-Reply-To: <20020214155716.3b810a91.sebastian.droege@gmx.de> <20020214180501.A1755@namesys.com> <20020214162232.5e59193b.sebastian.droege@gmx.de> <20020214172421.5d8ae63c.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020214172421.5d8ae63c.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Feb 14, 2002 at 05:24:21PM +0100, Sebastian Dröge wrote:

> reiserfsck --check said I have to do --rebuild-tree because of critical corruption (many "bad_leaf: block xxxxx has wrong order of items")...

these are 2.5.3 signs.

> after that I booted into 2.4.17. Everything works okay.
> Then I booted 2.5.5-pre1 and the mysterious files are there again after starting GNOME. I've copied one file to another location but when I reboot into 2.4.17 the files and the copy are gone again...

But GNOME is working, right?

> If you need one or two file names or the content of them just ask (They begin with an "^")... then I'll handcopy them ;)

I have a better approach.
Just recreate them (by running GNOME in 2.5.5-pre1?) and then tar them up ;)
Send the ersulting tar file to me.

> The format of the partition is 3.6 and another partition with 3.5 format had no errors... Maybe this helps

So now problem only is that there are strange files after GNOME start, right?
Do these files disa[[ear after you quit GNOME?

> I could build 2.5.5-pre1 without your patch from the last mail but for this try I have build the kernel with it
I just found this patch is only needed on SMP ;)

Bye,
    Oleg

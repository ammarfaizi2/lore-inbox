Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271824AbTHMLeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 07:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271827AbTHMLeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 07:34:16 -0400
Received: from www.13thfloor.at ([212.16.59.250]:16070 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271824AbTHMLeL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 07:34:11 -0400
Date: Wed, 13 Aug 2003 13:34:20 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Vid Strpic <vms@bofhlet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (no subject)
Message-ID: <20030813113420.GA2846@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	linux-kernel@vger.kernel.org
References: <20030813091453.GJ30507@home.bofhlet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030813091453.GJ30507@home.bofhlet.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 11:14:53AM +0200, Vid Strpic wrote:
> On Tue, Aug 12, 2003 at 04:55:19PM +0300, Catalin BOIE wrote:
> > "cat drivers/built-in.o > /dev/null" gives me i/o error.
> > Can I suspect a bad sector?
> 
> Where, in memory? :)  /dev/null is in memory :)

depends, if /dev/null does not exist before the cat,
it will be created as regular file, residing on the
device /dev is (which could be a disk ...)

ls -la /dev/null will show ...

> > I use reiserfs.
> 
> Any other file gives that?

best,
Herbert

> 
> -- 
>            vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
> Linux lorien 2.4.21 #1 Sat Jun 14 01:23:07 CEST 2003 i586
>  11:13:51 up 38 days, 21:33, 10 users,  load average: 0.03, 0.26, 0.18



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287139AbSABWsE>; Wed, 2 Jan 2002 17:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSABWrz>; Wed, 2 Jan 2002 17:47:55 -0500
Received: from tourian.nerim.net ([62.4.16.79]:46604 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S287143AbSABWrj>;
	Wed, 2 Jan 2002 17:47:39 -0500
Message-ID: <3C338DCC.3020707@free.fr>
Date: Wed, 02 Jan 2002 23:46:36 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020101
X-Accept-Language: en-us
MIME-Version: 1.0
To: esr@thyrsus.com
Cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102164757.A16976@thyrsus.com> <Pine.LNX.4.33.0201022305090.427-100000@Appserv.suse.de> <20020102170833.A17655@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:

> [...]

> 
> But this is not a bad reason.  Allowing people to avoid running suid 
> programs is a *good* reason.
> 

Usually yes. But for a code that simply parses /dev/kmem content without 
taking args...

Just took a quick look at dmidecode.c and auditing this code doesn't 
seem out of reach.

What's the difference security-wise between running this code in kernel 
space and in a suid prog? Avoiding loading libraries?

Frankly I don't see the point.

LB.


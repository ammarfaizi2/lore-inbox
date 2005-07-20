Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVGTNbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVGTNbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVGTNbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:31:40 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:43668 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261206AbVGTNbj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:31:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jq/o66wsedSdDRud3Ups79ikqm5zVKitdzJMrigc1eRC1PYuInNNsK1zaEj6lOp82m4+SpIHgHfaJaS4jkjRWHZlPi4HqijSFTam1Y36PJXo2uV5z4963C1H7N5oZGJKlHQAzOpAD0C2i/p8fEDjZE9WzSPs1ueCdPvp+jHwQbY=
Message-ID: <69304d110507200631564a73b1@mail.gmail.com>
Date: Wed, 20 Jul 2005 15:31:36 +0200
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: Antonio Vargas <windenntw@gmail.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: a 15 GB file on tmpfs
Cc: Bastiaan Naber <naber@inl.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20050720132006.GI7050@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507201416.36155.naber@inl.nl>
	 <20050720132006.GI7050@harddisk-recovery.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/05, Erik Mouw <erik@harddisk-recovery.com> wrote:
> On Wed, Jul 20, 2005 at 02:16:36PM +0200, Bastiaan Naber wrote:
> > I have a 15 GB file which I want to place in memory via tmpfs. I want to do
> > this because I need to have this data accessible with a very low seek time.
> 
> That should be no problem on a 64 bit architecture.
> 
> > I want to know if this is possible before spending 10,000 euros on a machine
> > that has 16 GB of memory.
> 
> If you want to spend that amount of money on memory anyway, the extra
> cost for an AMD64 machine isn't that large.
> 
> > The machine we plan to buy is a HP Proliant Xeon machine and I want to run a
> > 32 bit linux kernel on it (the xeon we want doesn't have the 64-bit stuff
> > yet)
> 
> AFAIK you can't use a 15 GB tmpfs on i386 because large memory support
> is basically a hack to support multiple 4GB memory spaces (some VM guru
> correct me if I'm wrong). Just get an Athlon64 machine and run a 64 bit
> kernel on it. If compatibility is a problem, you can still run a 32 bit
> i386 userland on an x86_64 kernel.
> 
> 
> Erik
> 
> --
> +-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
> | Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
> -

Bastian, Erik is dead-on on that one: go 64bit and forget all worries
about your 15GB filesize. Just don't forget to look not only x86-64
(intel or amd) but also itanium, ppc64 and s390 machines, you never
know about surprises!

-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.

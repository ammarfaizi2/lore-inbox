Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTAJOR1>; Fri, 10 Jan 2003 09:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTAJOR1>; Fri, 10 Jan 2003 09:17:27 -0500
Received: from angband.namesys.com ([212.16.7.85]:60868 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265196AbTAJOR0>; Fri, 10 Jan 2003 09:17:26 -0500
Date: Fri, 10 Jan 2003 17:26:07 +0300
From: Oleg Drokin <green@namesys.com>
To: Pascal Junod <pascal.junod@epfl.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL BUG: assertion failure in reiserfs code
Message-ID: <20030110172607.B9028@namesys.com>
References: <Pine.LNX.4.44.0301101340520.1906-100000@lasecpc10.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301101340520.1906-100000@lasecpc10.epfl.ch>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jan 10, 2003 at 01:49:37PM +0100, Pascal Junod wrote:

> My /tmp partition is using reiserfs and I get following message when
> copying a large file on it (there is enough room, and fsck.reiserfs says
> everything is ok...). Is this issue known ? My kernel version is the
> linux-2.4.19-gentoo-r10 one.

This is issue is not know, but on the way to 2.4.20 the block allocator in
reiserfs was replaced with another one.

> Jan 10 13:38:34 lasecpc29 kernel: vs-4010: is_reusable: block number is out of range 248999 (248999)

Hm... Very strange. I cannot think off hand have that might happen.
Can you reproduce it somehow?

Thanks for the report

Bye,
    Oleg

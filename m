Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290255AbSAXUpV>; Thu, 24 Jan 2002 15:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290257AbSAXUpM>; Thu, 24 Jan 2002 15:45:12 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:53257 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290255AbSAXUpB>; Thu, 24 Jan 2002 15:45:01 -0500
Message-ID: <3C5070CA.40B96B00@zip.com.au>
Date: Thu, 24 Jan 2002 12:38:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Berjoza Roman <b_rom_s@4enet.by>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs+updatedb=oops
In-Reply-To: <20020123161944Z289790-13996+10616@vger.kernel.org> <20020124132944.A20375@namesys.com> <20020124105404.02895225988@angband.namesys.com>,
		<20020124105404.02895225988@angband.namesys.com> <20020124135722.A26375@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
> On Thu, Jan 24, 2002 at 12:56:21PM +0200, Berjoza Roman wrote:
> 
> > Yes, yes, yes - you right. I have the same oops on ext2 today.
> > Sorry for incorrect report - i am newcomer in kernel testing, and updatedb
> > was not triggered :(
> You mean you are able to reproduce this reliably?
> Can you reproduce on 2.4.18-pre6?
> If yes, I believe VFS folks would be interested.
> 

It just looks like a standard memory-corruption crash.  We're
seeing these on a daily basis - far too many for it to
be hardware problems.  I'm collecting them, trying to
pick a pattern.

Berjoza, please send your .config and a description
of what sorts of things the machine is being used
for (network server, firewall, etc).

Thanks.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWEOXAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWEOXAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWEOXAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:00:48 -0400
Received: from [81.2.110.250] ([81.2.110.250]:64390 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750701AbWEOXAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:00:47 -0400
Subject: Re: Updated libata PATA patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Radloff <radsaq@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147730929.26686.168.camel@localhost.localdomain>
References: <1147196676.3172.133.camel@localhost.localdomain>
	 <3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
	 <1147270145.17886.42.camel@localhost.localdomain>
	 <3b0ffc1f0605100905x18d07f76jda38d1807cf9e9d7@mail.gmail.com>
	 <1147279198.19935.6.camel@localhost.localdomain>
	 <3b0ffc1f0605100939r607ef30dya743a7f1a1dbe03f@mail.gmail.com>
	 <1147730929.26686.168.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 00:13:36 +0100
Message-Id: <1147734817.26686.202.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 23:08 +0100, Alan Cox wrote:
> On Mer, 2006-05-10 at 12:39 -0400, Kevin Radloff wrote:
> > > I'll do some more digging, but putting printks into ata_qc_issue_prot to
> > > see where it explodes is the next step I suspect.
> > 
> > Ah, I see.. I'll be waiting. :)
> 
> Much scratching of heads and tracing later it looks like a libata-core
> bug rather than pata_pcmcia. Glad this blew up as its a nasty little bug
> if I follow it right

Actually ignore that (well try it if you like) but it appears something
far weirder is actually going on


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272546AbRIPQyi>; Sun, 16 Sep 2001 12:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272537AbRIPQy2>; Sun, 16 Sep 2001 12:54:28 -0400
Received: from hermes.domdv.de ([193.102.202.1]:55305 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272546AbRIPQyL>;
	Sun, 16 Sep 2001 12:54:11 -0400
Message-ID: <XFMail.20010916185020.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva>
Date: Sun, 16 Sep 2001 18:50:20 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: broken VM in 2.4.10-pre9
Cc: linux-kernel@vger.kernel.org, Ricardo Galli <gallir@m3d.uib.es>,
        Michael Rothwell <rothwell@holly-springs.nc.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16-Sep-2001 Rik van Riel wrote:
> On 16 Sep 2001, Michael Rothwell wrote:
> 
>> Is there a way to tell the VM to prune its cache? Or a way to limit
>> the amount of cache it uses?
> 
> Not yet, I'll make a quick hack for this when I get back next
> week. It's pretty obvious now that the 2.4 kernel cannot get
> enough information to select the right pages to evict from
> memory.
> 
In my experience you should try to run aide
(ftp://ftp.cs.tut.fi/pub/src/gnu/aide-0.7.tar.gz) for tests. This is a case of
one single process doing a file system consistency check and stopping all other
processes cold due to swapout due to heavy cacheing. While aide runs the system
just becomes unusable.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

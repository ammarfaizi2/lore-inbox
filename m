Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTBOMvi>; Sat, 15 Feb 2003 07:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTBOMvi>; Sat, 15 Feb 2003 07:51:38 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:25742 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261907AbTBOMvi>; Sat, 15 Feb 2003 07:51:38 -0500
Date: Sat, 15 Feb 2003 13:36:00 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
Message-ID: <20030215133600.F629@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com> <3E4CAEFC.92914AB3@libero.it> <1045232677.7958.9.camel@irongate.swansea.linux.org.uk> <3E4CF5D2.6ED23062@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3E4CF5D2.6ED23062@libero.it>; from abramo.bagnara@libero.it on Fri, Feb 14, 2003 at 02:57:38PM +0100
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18k1wi-0005xP-00*7EDYBJS36eM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 02:57:38PM +0100, Abramo Bagnara wrote:
> > Out of band data is a second data channel, so open two pipes. Jeez
> 
> What about the relation between the two channels?

Encoded in the program logic, where it belongs. We have enough
needless interrelations between API functions already.

If you would like to have two channels in one, than simply
implement a multiplexer in the program that needs it (look at ssh
for an example).

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

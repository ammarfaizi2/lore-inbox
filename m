Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262685AbRFQTeS>; Sun, 17 Jun 2001 15:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbRFQTeI>; Sun, 17 Jun 2001 15:34:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24337 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262685AbRFQTdz>; Sun, 17 Jun 2001 15:33:55 -0400
Subject: Re: Client receives TCP packets but does not ACK
To: pavel@suse.cz (Pavel Machek)
Date: Sun, 17 Jun 2001 20:32:49 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mblack@csihq.com (Mike Black),
        f.v.heusden@ftr.nl (Heusden Folkert van), linux-kernel@vger.kernel.org
In-Reply-To: <20010617201727.A1493@bug.ucw.cz> from "Pavel Machek" at Jun 17, 2001 08:17:27 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15BiHy-0002xC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Specifically
> > 1.	If the receiver closes and there is unread data many TCP's forget
> > 	to RST the sender to indicate that data was lost.
> 
> Do at least FreeBSD, Solaris and NT sent RST correctly?

I dont believe so

> > 2.	There is a flaw in the TCP protocol itself that is extremely unlikely
> > 	to bite people but can in theory cause wrong data in some unusual
> > 	circumstances that Ian Heavans found and has yet to be fixed by
> > 	the keepers of the protocol.
> 
> This is interesting; where are details?

http://www.schooner.com/~loverso/Public/Internet-Drafts/draft-heavens-problems-rsts-00.txt

Yes a 1996 tcp protocol flaw that still hasnt been fixed. 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRFQT0s>; Sun, 17 Jun 2001 15:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262681AbRFQT0j>; Sun, 17 Jun 2001 15:26:39 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:31236 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S262685AbRFQT03>;
	Sun, 17 Jun 2001 15:26:29 -0400
Message-ID: <20010617201727.A1493@bug.ucw.cz>
Date: Sun, 17 Jun 2001 20:17:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike Black <mblack@csihq.com>
Cc: Heusden Folkert van <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <03c701c0f5c8$e15f7e10$e1de11cc@csihq.com> <E15Az1U-0006wI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E15Az1U-0006wI-00@the-village.bc.nu>; from Alan Cox on Fri, Jun 15, 2001 at 08:12:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Specifically
> 1.	If the receiver closes and there is unread data many TCP's forget
> 	to RST the sender to indicate that data was lost.

Do at least FreeBSD, Solaris and NT sent RST correctly?

> 2.	There is a flaw in the TCP protocol itself that is extremely unlikely
> 	to bite people but can in theory cause wrong data in some unusual
> 	circumstances that Ian Heavans found and has yet to be fixed by
> 	the keepers of the protocol.

This is interesting; where are details?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

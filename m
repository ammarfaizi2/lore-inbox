Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTEZOvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTEZOvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:51:47 -0400
Received: from grouse.mail.pas.earthlink.net ([207.217.120.116]:44013 "EHLO
	grouse.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264399AbTEZOvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:51:45 -0400
From: Eric <eric@cisu.net>
Reply-To: eric@cisu.net
To: linux-kernel@vger.kernel.org
Subject: New make config options
Date: Mon, 26 May 2003 10:04:25 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305261004.25297.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#DEFINE RANT 1

Ok, I may not know what I'm talking about, or it may not actually be a good 
idea, but I had an ipifany about the configure scripts.

	 I spend most of my time in the configure script turning everything into a 
module. (I play alot, and I like to have modules available to explore). There 
should a button or something where it will turn everything that CAN be 
compiled as a module, into  kernel modules. Then you can de-select a few 
things and compile the other few options that you need directly into the 
kernel. 

#IFDEF RANT
It would save me alot of time knowing that all those stupid NIC cards are 
being compiled as modules when i'm not sure which one I have. I would rather 
have all the modules available in case  NIC breaks anyways.  I change NICS 
and i'm never sure what kind it is until it doesn't work and I need to 
compile ANOTHER module. I know some of them are obscure cards, but with all 
the options I can't really be sure if it's a card I might come across or not. 
I'd rather be safe and have a meg or two of NIC modules around then have to 
rebuild or compile a new modules when I find an exotic card. 
#ENDIF

	Modules aren't used used until they're needed anyways so It wouldn't cause 
conflicts or a big size differnece in the kernel (in my understanding). For 
us with fast machines(AMD XP1800+) it would just be an extra 5-7 minutes for 
the other modules to compile.

Would anyone else be interested in this?
----------------------
Eric Bambach   
Eric@CISU.net 
----------------------

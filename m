Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbRCORV5>; Thu, 15 Mar 2001 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131724AbRCORVv>; Thu, 15 Mar 2001 12:21:51 -0500
Received: from [63.109.146.2] ([63.109.146.2]:26863 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S131712AbRCORVN>;
	Thu, 15 Mar 2001 12:21:13 -0500
Message-ID: <B65FF72654C9F944A02CF9CC22034CE22E1B39@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>,
        christophe barbe <christophe.barbe@lineo.fr>
Cc: "Mike A . Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: Is swap == 2 * RAM a permanent thing?
Date: Thu, 15 Mar 2001 09:19:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIRC, when this discussion of swap size first came up, the general 
conclusion was NOT that you should have swap = 2 * RAM, but that you 
should have swap(2.4.x) = 2 * swap(2.2.x), that is, twice as much swap 
as you did under 2.2.x.

So if you never swapped at all under 2.2.x, you should not need any 
swap space in 2.4.x either. 

Is this correct?  

Also, what would be the consequences of not having "enough" swap?  
Just OOM faster?  Or more serious than that?

I have 512MB of RAM and rarely swap, so normally have just a 256MB
swap partition.  Is this bad?  It seems to work fine...

Thanks!

Torrey Hoffman

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291263AbSBGUMO>; Thu, 7 Feb 2002 15:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291262AbSBGUL5>; Thu, 7 Feb 2002 15:11:57 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:19987 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S291261AbSBGULf>;
	Thu, 7 Feb 2002 15:11:35 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Patrick Mochel <mochel@osdl.org>
Date: Thu, 7 Feb 2002 21:11:10 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
CC: <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <1126CC346B32@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Feb 02 at 10:27, Patrick Mochel wrote:

> Concerning reading/writing from offsets, it's up to the drivers for them 
> to either support it or not. In the files I've done so far, I return 0 if 
> show() is called with an offset. Which will give different results if you 
> read byte-by-byte or an entire chunk. 
> 
> It makes the callbacks simpler, but it is not technically correct. 

What about extremelly nice stuff Al Viro made for us in
fs/seq_file.c ? It made putting stuff into procfs really easy...
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTBTItp>; Thu, 20 Feb 2003 03:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTBTItp>; Thu, 20 Feb 2003 03:49:45 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:29333 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S261660AbTBTIto>; Thu, 20 Feb 2003 03:49:44 -0500
Message-ID: <3E54990A.1070007@nyc.rr.com>
Date: Thu, 20 Feb 2003 03:59:54 -0500
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCMCIA: cardmgr setting up two interfaces for one card?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting a strange error with the 2.5 kernels.  If the PCMCIA card 
is in the socket when I run cardmgr, cardmgr will load the appropriate 
module but inexplicably sets up two interfaces (eth1 and eth2 for 
example) for the same card.  The first interface (eth1), in this case, 
will not work -- even if i removed the modules and reinserted the card, 
etc.  However, if the card is NOT in the socket when I run cardmgr, 
inserting the card loads the modules and sets up the interfaces 
correctly.  This problem does not occur in the 2.4 kernel.

Does anyone have any suggestions?

-- 
(o- j o h n  e  w e b e r
//\  weber@nyc.rr.com
v_/_  aim/yahoo/msn: worldwidwebers


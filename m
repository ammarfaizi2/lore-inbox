Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282872AbRK0IPf>; Tue, 27 Nov 2001 03:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282851AbRK0IPW>; Tue, 27 Nov 2001 03:15:22 -0500
Received: from avalon.informatik.uni-freiburg.de ([132.230.150.1]:17644 "EHLO
	avalon.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id <S282864AbRK0INg>; Tue, 27 Nov 2001 03:13:36 -0500
Message-ID: <3C034B26.1010408@gmx.de>
Date: Tue, 27 Nov 2001 09:13:26 +0100
From: Jochen Eisinger <jochen.eisinger@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Patch for 2.4.15-pre7+ (was 2.4.14-pre7+ fs/proc/inode.c...)
In-Reply-To: <Pine.LNX.4.33.0111270114140.30432-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Hum, sending mails after midnight is prone for typos... I meant 2.4.15 
not 14...

If you have a closer look, you'll realize that the -pre7+ version only 
calls init_special_inode if there is no fileops structure in dir entry. 
alsa sets this entry always, resulting in wrong chardev entries in the 
/proc hierarchy

regards
-- jochen


-- 
   "I'd rather die before using Micro$oft Word"
     -- Donald E. Knuth
      (asked whether he'd reinvent TeX in the light of M$ Word)

   GnuGP public key for jochen.eisinger@gmx.de:
       http://home.nexgo.de/jochen.eisinger/pubkey.asc (0x8AEB7AE3)



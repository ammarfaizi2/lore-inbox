Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289500AbSAJPd6>; Thu, 10 Jan 2002 10:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289501AbSAJPds>; Thu, 10 Jan 2002 10:33:48 -0500
Received: from kochab.physics.uiowa.edu ([128.255.33.27]:14213 "EHLO
	kochab.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S289500AbSAJPdh>; Thu, 10 Jan 2002 10:33:37 -0500
Message-ID: <3C3DB4A9.AADB16B0@uiowa.edu>
Date: Thu, 10 Jan 2002 09:35:05 -0600
From: William Robison <william-robison@uiowa.edu>
Organization: University of Iowa
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFCA] Sound: adding /proc/driver/{vendor}/{dev_pci}/ac97 
 entry
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Alan mentioned that some cards make use of multiple codecs,
but also consider those of us that have multiple sound
cards when forming the '/proc' pathname.  As a quick&dirty
hack to allow two 1371 cards to co-exist in /proc, I added
the upper 8 bits of the address into the filename...

  (One sound card dedicated to being used as a 1200 baud
   modem for AX25 work, leaving one free for use as a
   normal soundcard)

regards
-Willy
William Robison

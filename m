Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTAJGjO>; Fri, 10 Jan 2003 01:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbTAJGjO>; Fri, 10 Jan 2003 01:39:14 -0500
Received: from web20508.mail.yahoo.com ([216.136.226.143]:4129 "HELO
	web20508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263215AbTAJGjO>; Fri, 10 Jan 2003 01:39:14 -0500
Message-ID: <20030110064758.12782.qmail@web20508.mail.yahoo.com>
Date: Thu, 9 Jan 2003 22:47:58 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: DMA timeouts on Promise 20267 IDE card
To: linux-kernel@vger.kernel.org
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1B7F@xch-a.win.zambeel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 check the CRC count on the first drive, hda. Its
 65584 !!! Thats huge. This
 CRC values result in UDMA downgrades. Also, check
 the reallocation sector
 count. A high value here means possible timeouts.
 With high reallocation
 sector count, there could be multiple mappings a
 drive would have to look
 into to get to the proper sector. You should change
 the drive hda and also
 the cable. Then try again. 
 
 Thanks
 Manish
 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com

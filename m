Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSHVRzp>; Thu, 22 Aug 2002 13:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHVRzo>; Thu, 22 Aug 2002 13:55:44 -0400
Received: from www.telenet.net ([204.97.152.225]:7942 "EHLO telenet.net")
	by vger.kernel.org with ESMTP id <S315198AbSHVRzk>;
	Thu, 22 Aug 2002 13:55:40 -0400
Date: Thu, 22 Aug 2002 13:59:45 -0400
From: Rob Speer <rob@twcny.rr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre2-ac4 IDE is slow
Message-ID: <20020822175945.GA743@twcny.rr.com>
Reply-To: rob@twcny.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Is-It-Not-Nifty: www.sluggy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I remember someone else bringing up this same issue, in which
case I'm sorry to have to ask again, but I can't find the message.

I'm going from 2.4.19 to 2.4.20-pre2-ac4 and the hard drive is noticably
slower in the new version. (It doesn't use DMA in either version - I
wish it did in ac4, but that's a separate problem.)

What I seem to remember from the other message is that there's some
parameter that can be changed to bring the speed back up. Could someone
tell me what it is?


If it helps: output of hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 77557/16/63, sectors = 78177792, start = 0

-- 
Rob Speer


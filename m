Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281700AbRKQEZc>; Fri, 16 Nov 2001 23:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281701AbRKQEZX>; Fri, 16 Nov 2001 23:25:23 -0500
Received: from cogent.ecohler.net ([216.135.202.106]:11420 "EHLO
	cogent.ecohler.net") by vger.kernel.org with ESMTP
	id <S281700AbRKQEZP>; Fri, 16 Nov 2001 23:25:15 -0500
Date: Fri, 16 Nov 2001 23:25:13 -0500
From: lists@sapience.com
To: linux-kernel@vger.kernel.org
Subject: [drm:radeon_freelist_get] *ERROR* returning NULL!
Message-ID: <20011117042513.GA8133@sapience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    I have a radeon card - when I turn on dri the machine later livelocks 
    with X spinning its wheels generating loads of messages like 
    these:

     [drm:radeon_freelist_get] *ERROR* returning NULL!
     last message repeated 2209 times


     This is triggered by trying to run (a) wolfenstein, or (b) Xconfigurator
     doing a probe or (c) possibly by some screen save but I'm not 100% 
     certain which screensaver.

     Kernel is 2.4.15-pre5 - I also changed the agp id (i860) in agp.h as per
     recent patch of Nicolas Aspert (from 2532 to 2531). Without
     this AGP was off and DRI was off. No problems crashes in this case.

     Distro is 7.2 fully updated. Machine is Dell 530 2 x 1.7Ghx P4.

     This may or may not be related but dpms doesn't work either, 
     XFree86 log has:

     (II) Loading extension DPMS
     (II) RADEON(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
     
     while xset q  shows
     DPMS (Energy Star):
        Display is not capable of DPMS

     What information can I provide that might help or is this a known
     problem with radeon?

     Regards 

     Gene/


    

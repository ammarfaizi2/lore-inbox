Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSFTMtt>; Thu, 20 Jun 2002 08:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSFTMts>; Thu, 20 Jun 2002 08:49:48 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:24080 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S314138AbSFTMto>;
	Thu, 20 Jun 2002 08:49:44 -0400
Message-ID: <3D11CF69.3030103@epfl.ch>
Date: Thu, 20 Jun 2002 14:49:45 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] Split up agpgart into per implementation files.
References: <fa.ep8m4pv.1gkki2v@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

 > There's lots more that can be done to cut down some of the duplication
 > that this patch introduces, but it's a good start at making the
 > backend code a little easier to navigate.
 >
 > Comments?
 >

Definitely a good idea !
The code is much easier to read.

For those interested in trying this with 2.4, here is an adaptation of 
the patch for 2.4.19-pre10-ac2 . I did not include neither the changes 
made in 2.5.23 (at least they should not be here), nor the intel 460 
stuff (not present in 2.4).

You can find the patch at :
http://ltswww.epfl.ch/~aspert/patches/agpgart-split-2.4.19-pre10-ac2.diff.bz2

For those using kbuild, a replacement for the Makefile.in in 
'drivers/char/agp' can be found at :
http://ltswww.epfl.ch/~aspert/patches/Makefile.in

Please test (it compiles OK but I don't have a test box at hand)

a+
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTETQms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 12:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTETQms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 12:42:48 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:38669 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263163AbTETQmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 12:42:46 -0400
Date: Tue, 20 May 2003 17:55:41 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Brett <generica@email.com>, <linux-kernel@vger.kernel.org>,
       <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
In-Reply-To: <20030520155138.GA29450@suse.de>
Message-ID: <Pine.LNX.4.44.0305201752240.28600-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, May 21, 2003 at 12:14:50AM +1000, Brett wrote:
> 
>  > since 2.5.67-bk5. I have been unable to boot my laptop
>  > tonight, I finally traced it back to
>  > http://linux.bkbits.net:8080/linux-2.5/cset@1.1006
> 
> good work.
> 
>  > the video card is a chips and tech 65545
>  > i'd just like to know where to go from here, so that I can return to 
>  > booting with CONFIG_VIDEO_SELECT set 
> 
> Possibly the card's VGA BIOS has 'issues' with that call.

This is most likely the case. I just tested out the configuration he has 
and it worked for me. I'm running vga=5 right now. For teh majority it 
works but as usual there are some broken BIOS that cause issues. 

> Wasn't the EDID stuff getting backed out anyways ?

Only in the VESA driver. Some people did have luck with the BIOS EDID info 
so I like to keep the BIOS call in there. 


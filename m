Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbTC0JUP>; Thu, 27 Mar 2003 04:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbTC0JUP>; Thu, 27 Mar 2003 04:20:15 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:48132 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261825AbTC0JUO>; Thu, 27 Mar 2003 04:20:14 -0500
Message-ID: <3E82C580.1000801@aitel.hist.no>
Date: Thu, 27 Mar 2003 10:33:52 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Antonino Daplas <adaplas@pol.net>
CC: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Much better framebuffer fixes.
References: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org> <1048735712.1047.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino Daplas wrote:
> On Thu, 2003-03-27 at 08:18, James Simmons wrote:
> 
>>Okay. Here are more framebuffer fixes. Please try these fixes and let me 
>>know how they work out for you.
>>
> 
> 
> This is a resend of the patch I previously sent.  I see that you have
> made changes to the logo drawing code targeted for monochrome logo
> drawing to use mono expansion.  You still need a few changes though,
> image->bg_color and image->fg_color must be initialized correctly when
> image->depth == 1.

This applied on top of James Simmons' patch, but didn't compile.
spin_lock_irqsave was "unknown".


Helge Hafting


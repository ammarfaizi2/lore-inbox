Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbTCNKJR>; Fri, 14 Mar 2003 05:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbTCNKJQ>; Fri, 14 Mar 2003 05:09:16 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:19467 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262776AbTCNKIk>; Fri, 14 Mar 2003 05:08:40 -0500
Message-ID: <3E71AD26.6080203@aitel.hist.no>
Date: Fri, 14 Mar 2003 11:21:26 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: VESA FBconsole driver?
References: <3E708815.23768.38089C@localhost> <3E70A68F.9422.AF1599@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:

> The reason why it would nice is so that the VESA FBconsole driver (and in 
> fact all the FBconsole drivers that use the real mode BIOS to set an 
> initial display mode) can restore that mode correctly when an application 
> exists and restores the console. Right now it is up to the application 
> program to restore the console, as the kernel has absolutely no way to do 
> it. If that program has not way to restore it (old SVGALib code for 
> instance) or the application crashes, you are stuck with a black screen 
> if you are using a framebuffer console. If the kernel knew how to call 
> the BIOS to restore the mode, this problem could be completely eliminated 
> and services could be provided to properly restore the system state

The bios isn't the way to go. Unless the bios coders puts an _ordinary_ 
linux kernel module in their eprom.

If the kernel knew how to restore the video state itself - that'd be 
something.  Go complain to those who keeps such knowledge secret.
And no, they won't risk their company on providing such information.
Setting the modes is such a tiny little piece of what a graphichs
card do.  (Providing full information on how to program the
accelerator chips wouldn't kill them either...)

Helge Hafting


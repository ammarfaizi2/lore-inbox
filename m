Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTK0NHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 08:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTK0NHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 08:07:55 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:26090
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S264516AbTK0NHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 08:07:52 -0500
Message-ID: <3FC5F8A7.1000709@reactivated.net>
Date: Thu, 27 Nov 2003 13:14:15 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031018 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: exiting X and rebooting
References: <200311270617.03654.gene.heskett@verizon.net>
In-Reply-To: <200311270617.03654.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which display driver are you using for X? Using Xinerama/multi-displays or similar?
I noticed this behaviour once on a dual-monitor setup. After starting X then 
exiting it, I noticed the problems that you describe on the primary monitor. 
However the secondary monitor was showing the output as normal (including 
cursor) if I remember correctly.
Both displays were running from a single GeForce4 Ti card, using the nvidia 
binary driver under X. No framebuffer.

Never found the problem, but never really investigated either.

Gene Heskett wrote:
> Greetings;
> 
> I'm not sure what category this minor complaint falls under, but since 
> its evidenced by a 2.6 kernel and not a 2.4, this seems like the 
> place.
> 
> One of the things I've been meaning to mention is that if I'm running 
> a 2.6 kernel, and exit X to reboot, the shell that had a cursor when 
> I started X from it, no longer has a cursor when x has been stopped.  
> This occurs only for 2.6 kernels, but works as usual for 2.4 kernels 
> giving a big full character block for a cursor.
> 
> One can still type, and the keystrokes are echo'd properly.  But it is 
> a bit un-nerving at first.  Logging clear out and back in again to 
> re-init the shell doesn't help.  The cursor is gone.
> 


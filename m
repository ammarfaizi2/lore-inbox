Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUBGK0j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 05:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUBGK0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 05:26:39 -0500
Received: from slask.tomt.net ([217.8.136.223]:25216 "EHLO pelle.tomt.net")
	by vger.kernel.org with ESMTP id S266721AbUBGK0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 05:26:36 -0500
Message-ID: <4024BCE4.2060600@tomt.net>
Date: Sat, 07 Feb 2004 11:24:36 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc1
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Ok, this is another big merge of a number of pending patches, although to 
> some degree the patches have now moved "outwards" from the core, and most 
> of them are in driver land.
> 
> There's a lot of network driver updates (have been in -mm and Jeff's 
> testing trees for a while), and Al Viro has been fixing up not just 
> network drivers, but also cursing over parport interfaces ;)
> 
> Andrew's patches are all over, from fixing warnings with new versions of
> gcc to merging things like the ppc updates he had in his tree, and 
> everything in between.
> 
> On and a big ALSA update, along with SCSI updates (big qla update, for
> example).
> 
> So let's calm down and make sure all the updates are ok.

pdc202xx_old OOPS's on load in case of completely modular IDE (core and 
pci ide drivers). I have yet to capture the OOPS, as someone has just 
ran away with the one serial cable over here.

If we're lucky Bart knows what's missing without the trace ( :-) ! ). If 
not, I'll see if I can get netconsole up and running.

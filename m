Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVDTXna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVDTXna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 19:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVDTXna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 19:43:30 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:17332 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S261843AbVDTXnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 19:43:23 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4266E912.9090209@s5r6.in-berlin.de>
Date: Thu, 21 Apr 2005 01:43:14 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
References: <20050417195706.GD3625@stusta.de> <20050419191328.GJ1111@conscoop.ottawa.on.ca> <1113939827.6277.86.camel@laptopd505.fenrus.org> <42657F7C.8060305@s5r6.in-berlin.de> <1113981989.6238.30.camel@laptopd505.fenrus.org> <426683E9.4080708@s5r6.in-berlin.de> <1114029144.5085.20.camel@kino.dennedy.org> <20050420204932.GQ5489@stusta.de>
In-Reply-To: <20050420204932.GQ5489@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Wed, Apr 20, 2005 at 04:32:24PM -0400, Dan Dennedy wrote:
>>Based upon my experience of several years on this project there is only
>>one external kernel module project we need to consider because that
>>developer has been involved and voiced requirements. That is Arne
>>Caspari's (The Imaging Source) DFG/1394 driver. 
> 
> The ideal solution would be to get this driver included in the kernel.
> Are there any reasons against including it?

Arne stated his reasons: http://marc.theaimsgroup.com/?m=110361846312128
(BTW, does Arne have commit access to the linux1394 repo yet?)

>>I vote to remove external symbols not used by the Linux1394.org modules
>>or the module at http://sourceforge.net/projects/video-2-1394/
>>Of course, I may be voted down, but I ask the others to be realistic
>>about what we are arguing for (i.e. just being defensive?) and consider
>>the fact that there are valid reasons for their removal.

Yes, there are. (Although one of the reasons -- size of the kernel -- is 
in effect neglectible.) So let's see if further opinions are coming in 
at the lists now. Then let's decide how to manage removal of the stuff.

> The DFG/1394 driver requires hpsb_read and hpsb_write.
> 
> Are there any Linux1394.org modules that are not in 2.6.12-rc2-mm3?

No.
-- 
Stefan Richter
-=====-=-=-= -=-- =-=-=
http://arcgraph.de/sr/

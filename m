Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTLVBfq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTLVBfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:35:46 -0500
Received: from 12-208-144-233.client.attbi.com ([12.208.144.233]:55681 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S264296AbTLVBfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:35:44 -0500
Message-ID: <3FE64A6E.2020506@comcast.net>
Date: Sun, 21 Dec 2003 17:35:42 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicklas Bondesson <nikomail@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
References: <BAY8-DAV35IMKT7Fvnj0000fb07@hotmail.com>
In-Reply-To: <BAY8-DAV35IMKT7Fvnj0000fb07@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicklas Bondesson wrote:
> Now I'm sucessfully booting my system with the 2.4.23 kernel using only one
> of the drives (hde). There is not a single line in the logs that says
> anything about the Promise ATARAID driver is beeing fired up, so my guess is
> that it doesn't load if no one is calling on it. When I try to boot from the
> RAID it dies right after the "NET4: Unix domain sockets 1.0/SMP for Linux"
> message. I think it's when the ATARAID driver is about to fire up. I have no
> idea at all what to do now. It must have something to do with the hard
> drives since this is the only thing that has changed. Maybee I'm missing
> some important kernel setting option or so? (I don't think so, but one never
> know for sure). Also what have changed in the Promise / ATARAID since
> 2.4.18?.
> 
> /Nicke

Not sure what else to tell you. If the pdcraid driver is compiled into the
kernel, you'll get a message about it during boot, even if it can't find all the
drives. I no longer use the 2.4 kernel series (or pdcraid), so I'm afraid I'm
out of ideas. Maybe somebody else on the list has some other things to try. Sorry.

-Walt




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319572AbSH3ONR>; Fri, 30 Aug 2002 10:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319573AbSH3ONR>; Fri, 30 Aug 2002 10:13:17 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:989 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S319572AbSH3ONQ>; Fri, 30 Aug 2002 10:13:16 -0400
Message-ID: <3D6F7E7B.9010905@web.de>
Date: Fri, 30 Aug 2002 16:17:31 +0200
From: Tim Habermann <tim_habermann@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: USB mouse in 2.4.19-pre4 vs later
References: <20020830140719.GA24738@danielle.hinet.hr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mario,

I had the same issue migrating from 2.4.18 to plain 2.4.19. Activating 
the new option "HID input layer support" under USB support fixed this.

Best regards
Tim


Mario Mikocevic wrote:
> Hi,
> 
> after 2.4.19-pre4 (or could it be pre5 I haven't tried pre5)
> my USB mouse stopped working in X.
> 
> Only relevant diff I could find is (same .config) ->
> 
> -input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:3.0
> +hiddev0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:3.0
> 
> this is 19-pre4 vs 19-pre6.
> 
> Any help ?
> TIA,
> 
> 


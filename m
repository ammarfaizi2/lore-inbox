Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318783AbSHBLkQ>; Fri, 2 Aug 2002 07:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318784AbSHBLkQ>; Fri, 2 Aug 2002 07:40:16 -0400
Received: from [195.63.194.11] ([195.63.194.11]:39942 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318783AbSHBLkP>; Fri, 2 Aug 2002 07:40:15 -0400
Message-ID: <3D4A6F43.4010908@evision.ag>
Date: Fri, 02 Aug 2002 13:38:43 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
References: <1028288066.1123.5.camel@laptop.americas.sgi.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Stephen Lord napisa³:
> In 2.5.30 I started getting these warning messages out ide during
> the mount of an XFS filesystem:
> 
> ide-dma: received 1 phys segments, build 2
> 
> Can anyone translate that into English please.

It can be found in pcidma.c.
It is repoting that we have one physical segment needed by
the request in question but the sctter gather list allocation
needed to break it up for mapping in two.



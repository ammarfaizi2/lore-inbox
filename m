Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290081AbSBKSs7>; Mon, 11 Feb 2002 13:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290080AbSBKSsu>; Mon, 11 Feb 2002 13:48:50 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:24493 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S290075AbSBKSsm>; Mon, 11 Feb 2002 13:48:42 -0500
Message-ID: <3C681205.1050504@nyc.rr.com>
Date: Mon, 11 Feb 2002 13:48:37 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.4 Sound Driver Problem
In-Reply-To: <E16aKwN-0007Ro-00@the-village.bc.nu> <3C6809C2.1030808@nyc.rr.com> <20020211132725.A18726@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is wonderful, but how is this related to ymfpci?

I don't know.  All I know is that _I_ did not enable persistent dma 
buffers in my kernel config, so I blamed this dmap stuff on ymfpci 
(which is the only sound option that I enabled).

I do see that CONFIG_SOUND_GAMEPORT is enabled automatically
(perhaps by the OSS option).  Do you think this is what is requiring 
sound_alloc_dmap() ?

Thanks for all your help!


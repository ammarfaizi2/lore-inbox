Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268399AbTBSMuP>; Wed, 19 Feb 2003 07:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268405AbTBSMuP>; Wed, 19 Feb 2003 07:50:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53750 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S268399AbTBSMuO>; Wed, 19 Feb 2003 07:50:14 -0500
Date: Wed, 19 Feb 2003 14:00:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH 2.4.21-pre4|BK] remove /proc/meminfo:MemShared
Message-ID: <20030219130008.GD531@fs.tum.de>
References: <200302191333.43875.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302191333.43875.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 01:42:34PM +0100, Marc-Christian Petersen wrote:

> Hi Marcelo,

Hi Marc,

> it seems to have been displaying zero for the past several years.
> 
> Same as in 2.5, by AKPM.
>...

I don't think it's good to do this change in a stable kernel series. The 
entry doesn't do any harm and there might be programs that parse 
/proc/meminfo and expect MemShared to be present.

> ciao, Marc

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


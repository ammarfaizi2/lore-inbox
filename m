Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267943AbTBNVAs>; Fri, 14 Feb 2003 16:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTBNU67>; Fri, 14 Feb 2003 15:58:59 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42732 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267815AbTBNU6H>; Fri, 14 Feb 2003 15:58:07 -0500
Date: Fri, 14 Feb 2003 22:07:54 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: creating incremental diffs
Message-ID: <20030214210754.GN20159@fs.tum.de>
References: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0302142147360.12353@dns.toxicfilms.tv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 09:48:16PM +0100, Maciej Soltysiak wrote:

> Hi,

Hi Maciej,

> let's say i want to create an incremental diff between
> 2.4.21pre4aa1 and aa2.
> 
> how do i do that?

install Tim Waugh's patchutils [1] and do an

  interdiff -z 2.4.21pre4aa1.gz 2.4.21pre4aa2.gz > my-aa1-aa2

> Regards,
> Maciej Soltysiak

cu
Adrian

[1] http://cyberelk.net/tim/data/patchutils/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


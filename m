Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTLFUv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 15:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbTLFUv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 15:51:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13044 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263984AbTLFUv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 15:51:26 -0500
Date: Sat, 6 Dec 2003 21:51:18 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jens Benecke <jens-usenet@spamfreemail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which optimization for different CPUs?
Message-ID: <20031206205118.GT20739@fs.tum.de>
References: <bqs8iq$2c3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bqs8iq$2c3$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 10:47:10AM +0100, Jens Benecke wrote:

> Hi,

Hi Jens,

> I have several servers and workstations. What optimization level in the
> kernel configuration is the maximum possible if I want to use the same
> kernel 
> 
> - on a Duron-650, a Celeron-1000, and a Celeron-2600?  (servers)
> - additionally on a K6-3D 400 and a K6-2 350?
>   (do I *have* to go down to CONFIG_M586 or does P2 or P-MMX work?)
> 
> - on a P3-700, an Athon XP 2400, and a P4-1800+? (workstations)

you must go down to M586TSC .

> Thank you!
> Jens Benecke

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


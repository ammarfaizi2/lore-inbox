Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTANOht>; Tue, 14 Jan 2003 09:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTANOhs>; Tue, 14 Jan 2003 09:37:48 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50392 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263204AbTANOhp>; Tue, 14 Jan 2003 09:37:45 -0500
Date: Tue, 14 Jan 2003 15:46:32 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Corey Minyard <cminyard@mvista.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       Corey Minyard <minyard@mvista.com>
Subject: Re: IPMI
Message-ID: <20030114144632.GU21826@fs.tum.de>
References: <20030114084011.6AB412C466@lists.samba.org> <3E241ECD.6000108@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E241ECD.6000108@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 08:29:33AM -0600, Corey Minyard wrote:
> Does this work, or would you like more detail?
> 
> config IPMI_HANDLER
>       tristate 'IPMI top-level message handler'
>       help
>         This enables the central IPMI message handler, required for IPMI
>         to work.  Note that you must have this enabled to enable any
>         other IPMI things.  IPMI is a standard for managing sensors
>         (temperature, voltage, etc.) in a system.  If you don't know
>         what it is, your system probably doesn't have it and you can
>         ignore this option.  See Documentation/IPMI.txt for more
>         details on the driver.


What about the following?


config IPMI_HANDLER
      tristate 'IPMI top-level message handler'
      help
        This enables the central IPMI message handler, required for IPMI
        to work.

        IPMI (Intelligent Platform Management Interface) is one standard 
        for managing sensors (temperature, voltage, etc.) in a system.

        See Documentation/IPMI.txt for more details.

        If unsure, say N.


> -Corey

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


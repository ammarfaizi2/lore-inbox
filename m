Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293630AbSCLWID>; Tue, 12 Mar 2002 17:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311357AbSCLWHx>; Tue, 12 Mar 2002 17:07:53 -0500
Received: from mail1.home.nl ([213.51.129.225]:50939 "EHLO mail1.home.nl")
	by vger.kernel.org with ESMTP id <S293630AbSCLWHf>;
	Tue, 12 Mar 2002 17:07:35 -0500
From: Frank van de Pol <fvdpol@home.nl>
Date: Tue, 12 Mar 2002 23:01:29 +0100
To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        "S. Chandra Sekharan" <sekharan@us.ibm.com>
Subject: Re: [PATCH] Support for assymmetric SMP
Message-ID: <20020312230128.A3838@idefix.fvdpol.home.nl>
In-Reply-To: <20020311043421.D2346@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311043421.D2346@nbkurt.etpnet.phys.tue.nl>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.13-ac4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 04:34:21AM +0100, Kurt Garloff wrote:
> Hi,
> 
> some time ago (2.4.2 time), I created a patch that allows using a
> multiprocessor system with different speed ix86 CPUs and Linux.
> 
> The patch does the following:
> * Make sure we got the flags right (in case they are different) before we
>   enable XMM/FXSR/.... Right means common subset of supported features.

Running quasi symetric system (dual P-II 300 MHz, but different cores, one
is Klamath, other is Deschutes) the fix for the flags is very usefull and
I'd like to see it integrated in the stock kernels. Perhaps the flags and
the (more controversial) speed patches can be split?

Regards,
Frank. 


-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?

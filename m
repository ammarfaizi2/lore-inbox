Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135296AbRDLTxG>; Thu, 12 Apr 2001 15:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135297AbRDLTwy>; Thu, 12 Apr 2001 15:52:54 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31916 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135296AbRDLTwm>;
	Thu, 12 Apr 2001 15:52:42 -0400
Message-ID: <3AD6078A.AB086F5C@mandrakesoft.com>
Date: Thu, 12 Apr 2001 15:52:42 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
In-Reply-To: <200104121236.FAA03613@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
>         For anyone who is interested, I have produced a list of all
> of the .data variables that contain all zeroes and could be moved to
> .bss within the kernel and all of the modules (all of the modules
> that we build at Yggdrasil for x86, which is almost all).  These
> are global or static variables that have been declared

Thanks, but Andrey Panin did you one better -- he produced a patch which
fixes up a good number of these.  You should follow lkml more closely :)

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."

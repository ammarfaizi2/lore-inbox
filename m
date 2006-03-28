Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWC1QVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWC1QVX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWC1QVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:21:23 -0500
Received: from smtpout.mac.com ([17.250.248.73]:33219 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932113AbWC1QVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:21:22 -0500
In-Reply-To: <442960B6.2040502@tremplin-utc.net>
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com> <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net> <44271E88.6040101@tremplin-utc.net> <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com> <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr> <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com> <442960B6.2040502@tremplin-utc.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <7E2F0C3C-4091-4EEB-8E10-C1F58F94BD59@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [OT] Non-GCC compilers used for linux userspace
Date: Tue, 28 Mar 2006 11:20:50 -0500
To: Eric Piel <Eric.Piel@tremplin-utc.net>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 28, 2006, at 11:13:42, Eric Piel wrote:
> 03/28/2006 05:57 PM, Kyle Moffett wrote/a écrit:
>> But my question still stands.  Does anybody actually use any non- 
>> GCC compiler for userspace in Linux?
>
> At least in the domain of HPC, I've seen people which were  
> compiling mostly *everything* with the intel compiler (x86 and  
> ia64) for performance reason. So... yes userspace is sometimes  
> compiled with non-GCC compiler :-)

Ok, well, the Intel compiler actually ends up emulating GCC and  
supports most of its extensions; supposedly it can even be used to  
compile the kernel sources, as per include/linux/compiler-intel.h. (I  
don't know how recently this has been tested, though)  So does  
anybody compile userspace under anything other than GCC or Intel  
compilers?  Do any such compilers even exist?

Cheers,
Kyle Moffett


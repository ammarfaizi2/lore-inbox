Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVE3OPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVE3OPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVE3OPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:15:12 -0400
Received: from smtpout.mac.com ([17.250.248.73]:54011 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261602AbVE3OPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:15:03 -0400
In-Reply-To: <429B0683.nail5764GYTVC@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <46BE0C64-1246-4259-914B-379071712F01@mac.com>
Cc: toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Date: Mon, 30 May 2005 10:14:37 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 30, 2005, at 08:26:43, Joerg Schilling wrote:
> Toon van der Pas <toon@hout.vanvergehaald.nl> wrote:
>
>
>>> look up the man page for udev(8), pay particular attention to the  
>>> part
>>> that can tie devname into device serial number.
>>> take note of the example shown under 'serial'.
>>>
>>
>> These were my thoughts too.
>> But I just checked the entries in my sysfs tree for my CDRW drive,
>> and there is no serial number available...
>>
>
> BTW: an implementation that uses something like Solaris does with
> /etc/path_to_inst and puts USB serial numbers into the path_to_inst
> kernel instance database could come very close to the desired result
> and would give stable SCSI addresses too.

But why fix what isn't broken?  I can tell all my other programs, from
dd to mount, that I want to use the udev-created /dev/green_burner, so
why do you indicate such usage is _deprecated_ in cdrecord?  For such
device nodes, a _filesystem_ is the preferred name=>number index, so
why add an extra strange file "just because Solaris does".

And why again do you need stable SCSI addresses for my _USB_ drive?



Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293635AbSB1Rcu>; Thu, 28 Feb 2002 12:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293122AbSB1Raa>; Thu, 28 Feb 2002 12:30:30 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22026
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S293510AbSB1R1c>; Thu, 28 Feb 2002 12:27:32 -0500
Date: Thu, 28 Feb 2002 09:14:13 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Dave Jones <davej@suse.de>
cc: Tim Moore <timothymoore@bigfoot.com>, linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <20020228125640.A32662@suse.de>
Message-ID: <Pine.LNX.4.10.10202280910170.24124-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Dave Jones wrote:

> On Wed, Feb 27, 2002 at 08:51:44PM -0800, Andre Hedrick wrote:
>  > 
>  > What is more useful is the cat /proc/ide/ide0/config !!!
>  > Oh and for those not reading this email, it is a side note on why the ide
>  > proc-pci interface had best be left alone and in tact. 
> 
>  And lspci -xxx is insufficent because?

You and I know it is the functional equivalent; however, in development of
driver it is more practical and faster to issue

echo PXX:YY > config

setpci XX.YY.Z blah blah ...

So if there is a real issue with its presense, apply a uuid test for
access.  Everything else has it so this should too.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development


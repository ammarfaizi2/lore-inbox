Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWBIXOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWBIXOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWBIXOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:14:54 -0500
Received: from smtpout.mac.com ([17.250.248.47]:1019 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750820AbWBIXOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:14:53 -0500
In-Reply-To: <mj+md-20060209.095744.7127.atrey@ucw.cz>
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner> <mj+md-20060209.095744.7127.atrey@ucw.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <233CD3FF-0017-4A74-BE6A-0487DF3F4EA8@mac.com>
Cc: Martin Mares <mj@ucw.cz>, jim@why.dont.jablowme.net, peter.read@gmail.com,
       Matthias Andree <matthias.andree@gmx.de>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Thu, 9 Feb 2006 18:14:40 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> -	how to use /dev/hd* in order to scan an image from a scanner
> -	how to use /dev/hd* in order to talk to a printer
> -	how to use /dev/hd* in order to talk to a jukebox
> -	how to use /dev/hd* in order to talk to a graphical device

Does cdrecord scan images, print files, or talk to SCSI graphical  
devices? No! Why do you care?  And furthermore, why the hell would  
you try to talk to one of those things via /dev/hd* anyways?  They  
certainly aren't ATA devices (aside from maybe a couple proprietary  
ATA jukeboxes, but those are likely SCSI anyways).

> -	how to use /dev/hd* in order to talk to a CPU device

Does cdrecord talk to CPU devices? No! Why do you care?  BTW: What  
the hell is a "CPU device" and why the hell would you think you could  
talk to it through a disk interface, let alone some other random SCSI  
interface?

> -	how to use /dev/hd* in order to talk to a tape device

Does cdrecord write to ATAPI tapes?  Not usually.  Why do you care?   
It's a possible bug in that /dev/hd* doesn't support ATAPI tapes, but  
nobody uses those anymore anyways (if it matters feel free to submit  
a bug report and patch).

By the way, are you ever actually going to try to point out any  
_actual_ problems?

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare



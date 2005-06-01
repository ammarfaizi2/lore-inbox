Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVFAQ4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVFAQ4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 12:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVFAQ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 12:56:43 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:51614 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261468AbVFAQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 12:56:36 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Jun 2005 18:55:16 +0200
To: schilling@fokus.fraunhofer.de, jim@why.dont.jablowme.net
Cc: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, kraxel@suse.de, dtor_core@ameritech.net,
       7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429DE874.nail7BFM1RBO2@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org>
 <429DD036.nail7BF7MRZT6@burner> <20050601154245.GA14299@voodoo>
In-Reply-To: <20050601154245.GA14299@voodoo>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Crilly" <jim@why.dont.jablowme.net> wrote:

> > I did define this model 19 years ago when I did write the first 
> > Generic SCSI driver at all. Adaptec indepentently did develop ASPI
> > 2 years later and did chose the same address model. Nearly all
> > OS use this kind (or a very similar model) internaly inside the kernel
> > or the basic SCSI address routines.
>
> Just because it's old, that doesn't mean it's good. The kernel using the

Just because it is old, it does not mean that it is bad....

It is the only interface that did not need to be modified since then.
The current driver interface is still 100% binary compatible to the
one I made in August 1986.

> numbers internally makes sense, but requiring them for userspace seems
> stupid. All you should do is open the appropriate device node and let the
> kernel figure out which SCSI ID to send the commands to. Every other tool
> I've ever seen uses device nodes, why should cdrecord be different? All it
> does is make cdrecord more difficult to use.

Note that Linux did not have a usable /dev/whatever based interface 10 years ago.
Also note that cdda2wav distinguishes between "OS native Audio ioctl calls" and
generic SCSI from checking the dev= parameter. For this reason using 
/dev/whateter is just wrong. Take it this way or you are a victim of you own 
decision to ignore the documentation of a program.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily

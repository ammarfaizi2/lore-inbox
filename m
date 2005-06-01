Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVFARef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVFARef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFARe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:34:28 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:56326 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261491AbVFARd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:33:56 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Wed, 1 Jun 2005 13:29:00 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, kraxel@suse.de, dtor_core@ameritech.net,
       7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050601172900.GC14299@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
	linux-kernel@vger.kernel.org, kraxel@suse.de,
	dtor_core@ameritech.net, 7eggert@gmx.de
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org> <429DD036.nail7BF7MRZT6@burner> <20050601154245.GA14299@voodoo> <429DE874.nail7BFM1RBO2@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429DE874.nail7BFM1RBO2@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/05 06:55:16PM +0200, Joerg Schilling wrote:
> "Jim Crilly" <jim@why.dont.jablowme.net> wrote:
> 
> >
> > Just because it's old, that doesn't mean it's good. The kernel using the
> 
> Just because it is old, it does not mean that it is bad....

Agreed and AFAIK most unix users prefer to use filenames to access their
devices. Why bother populating /dev at all if half if your apps require
random ID numbers to use them?

> > numbers internally makes sense, but requiring them for userspace seems
> > stupid. All you should do is open the appropriate device node and let the
> > kernel figure out which SCSI ID to send the commands to. Every other tool
> > I've ever seen uses device nodes, why should cdrecord be different? All it
> > does is make cdrecord more difficult to use.
> 
> Note that Linux did not have a usable /dev/whatever based interface 10 years ago.
> Also note that cdda2wav distinguishes between "OS native Audio ioctl calls" and
> generic SCSI from checking the dev= parameter. For this reason using 
> /dev/whateter is just wrong. Take it this way or you are a victim of you own 
> decision to ignore the documentation of a program.

I don't use cdda2wav so I can't comment, but every other ripping tool that
I've used on Linux has had no problem using the /dev/whatever interface, so
once again it appears that your tool is the blacksheep for no good reason.

> 
> Jörg
>

Jim.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264485AbTCXXYc>; Mon, 24 Mar 2003 18:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264486AbTCXXYb>; Mon, 24 Mar 2003 18:24:31 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:31625 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S264485AbTCXXY3>; Mon, 24 Mar 2003 18:24:29 -0500
Date: Mon, 24 Mar 2003 18:01:07 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Steven Pritchard <steve@silug.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware driver errors
Message-ID: <20030324180107.A14746@vger.timpanogas.org>
References: <20030324212813.GA6310@osiris.silug.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030324212813.GA6310@osiris.silug.org>; from steve@silug.org on Mon, Mar 24, 2003 at 03:28:13PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There is a firmware upgrade you need to obtain from WD if you are using their 
drives with a 3Ware controller.  The WD drives were optimized for desktop use
and they go into a "powersave" mode of sorts which will cause them to disappear
and reappear mysteriously with all sorts of strange errors.  WD is aware of 
this problem and so is 3Ware.

Jeff

On Mon, Mar 24, 2003 at 03:28:13PM -0600, Steven Pritchard wrote:
> (Apparently 3w-xxxx in the Subject gets caught as spam.  Somebody
> might want to adjust that regular expression.  :-)
> 
> I have a server that is locking up every day or two with a console
> full of this error:
> 
>     3w-xxxx: scsi0: Command failed: status = 0xcb, flags = 0x37, unit #0.
> 
> This is on a Dell PowerEdge 1400SC (dual PIII/1.13GHz, 1.1GB RAM),
> with a 3ware Escalade 7000-2 and two WD1600JB drives, running Red Hat
> 8.0 with kernel-smp 2.4.18-27.8.0.
> 
> I plan to report this to Red Hat's bugzilla, but I'm hoping for some
> ideas or big red flags to jump out at somebody here...  I use this box
> for a UML hosting server, so all this downtime is affecting *way* too
> many people.
> 
> This box has been having other stability problems, so I'm guessing
> this might not be directly related to the 3ware card/driver.  It did
> survive a memtest86 pass.
> 
> Steve
> -- 
> steve@silug.org           | Southern Illinois Linux Users Group
> (618)398-7360             | See web site for meeting details.
> Steven Pritchard          | http://www.silug.org/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273191AbRIJEJX>; Mon, 10 Sep 2001 00:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273192AbRIJEJN>; Mon, 10 Sep 2001 00:09:13 -0400
Received: from mail.tconl.com ([204.26.80.9]:45322 "EHLO hermes.tconl.com")
	by vger.kernel.org with ESMTP id <S273191AbRIJEJF>;
	Mon, 10 Sep 2001 00:09:05 -0400
Message-ID: <3B9C3CE9.D33DEE5@tconl.com>
Date: Sun, 09 Sep 2001 23:09:13 -0500
From: Joe Fago <cfago@tconl.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jacob@chaos2.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9: PDC20267 not working
In-Reply-To: <Pine.LNX.4.21.0109091843220.31509-100000@inbetween.blorf.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacob Luna Lundberg wrote:
> 
> On Sun, 9 Sep 2001, Joe Fago wrote:
> 
> > System hangs on boot:
> 
> > PDC20267: IDE controller on PCI bus 00 dev 40
> 
> > This is the only device attached to the controller. Any suggestions?
> 
> I have seen this before.  I have a system that will do it every time right
> now, in fact.  You can try setting interrupts to edge-triggered in your
> BIOS if it has such an option; this usually ``fixes'' the problem for me.
> Of course, it will mean you can't share PCI interrupts, if I understand it
> correctly.  However, I'm not sure what's going on and nobody has commented
> on it thus far that I know of.  :(
> 
> -Jacob
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Thanks, that worked -- well the opposite worked. I had to set mine to 
triggered by `level' rather than `edge'. But I never would have suspected
it if you hadn't brought it up.

Thanks Again,
Joe

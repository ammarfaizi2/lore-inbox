Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133037AbQL3HZx>; Sat, 30 Dec 2000 02:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133039AbQL3HZm>; Sat, 30 Dec 2000 02:25:42 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:15367
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S133037AbQL3HZU>; Sat, 30 Dec 2000 02:25:20 -0500
Date: Fri, 29 Dec 2000 22:54:39 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Raymond Carney <rayc@atlanta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: New info -- HPT370 RAID support now possible? (was New possibilities
 for  HPT370 RAID support?)
In-Reply-To: <3A4D7D32.20A9DC87@atlanta.com>
Message-ID: <Pine.LNX.4.10.10012292247350.15613-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have email Soren a few days ago and asked him about how he did the
decoding of the RAID Signatures on the media and he has not replied.
Soren and I talk on a semi-quarterly basis to brag and boast/gloat.

For the record I have the information on the array content, and the raid
engin design, but can not derive a sane use for Linux.

FreeBSD use a CAM layer so they can do some things that Linux can not but
they have a perfoamance price that Linux does not have.

You take CAM->SCSI->ATA and back and you see how nasty that crap is in the
performance market.  If you want to tear into FreeBSD and extract the
information for me go for it.

I have a MESS known as CPRM to stop and I am in the middle of drafting a
counter proposal to prevent the CPU/PC/Computer world from being royally
screwed by Hollywood.

http://www0.mercurycenter.com/svtech/news/top/docs/copy122900.htm

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

On Sat, 30 Dec 2000, Raymond Carney wrote:

> I've read everything that I can find regarding support of the Highpoint
> controllers RAID functionality under Linux, and I understand what the issues
> have been. The one promising bit of information that I dug up in this process is
> that the 'pseudo' RAID functionality of the Highpoint and Promise IDE RAID
> controllers is now supported in FreeBSD (4.2-RELEASE and 5.0-CURRENT). My
> question is, can the new BSD code be leveraged to add support for these
> controllers to the Linux kernel, and could we reasonably expect to see such
> support in the near future?
> 
> (I think that most all of the relevant/important bits are in ata-raid.c and/or
> ata-raid.h. In
> any event, the IDE/ATA guy over on the FreeBSD side is Soren Schmidt
> (sos@freebsd.org), and he
> wrote all of the stuff for this. It is my understanding that he got all of the
> info on how Highpoint lays out the geometry of the array directly from
> Highpoint, and that they were "very forthcoming" with whatever information that
> the FreeBSD team asked for. 
> 
> There are also indications of support in OpenBSD and NetBSD's pciide driver,
> based on work done by Chris Cappuccio (chris@dqc.org) and Manuel Bouyer
> (bouyer@netbsd.org))
> 
> 
> Please CC: me directly on any replies, and Thanks very much in advance.
> -- 
>     ______________________________________________________________________ 
> /***   ________________________________________________________________   ***\
>  Raymond Carney       <> Discovery consists of seeing what everybody 
>  rayc@atlanta.com     <> has seen and thinking what nobody has thought. 
>  860.774.1939         <>                     - Albert Von Szent-Gyorgyi 
>        ________________________________________________________________ 
> \***______________________________________________________________________***/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280456AbRKXXFp>; Sat, 24 Nov 2001 18:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280510AbRKXXFf>; Sat, 24 Nov 2001 18:05:35 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:35113 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S280456AbRKXXFW>; Sat, 24 Nov 2001 18:05:22 -0500
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: linux-kernel@vger.kernel.org,
        Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: Sun, 25 Nov 2001 00:04:50 +0100
MIME-Version: 1.0
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <3C0035A2.24075.FFE9A8@localhost>
In-Reply-To: <20011124184119.C12133@emma1.emma.line.org> (Matthias Andree's message of "Sat, 24 Nov 2001 18:41:19 +0100")
In-Reply-To: <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I've always favoured IBM disks in all my hardware, from enterprise external 
scsi raid hardware to small ide hardware raid devices (3ware fyi). At home all 
my four disks are IBM (two DTLA). But with your information it seems i have 
been bitten by that problem twice at the same time. Several months ago a less 
zealous system administrator, while shutting down a couple servers for 
maintenance at night, made a mistake in the console kvm switch, and pushed 
the red button on a live server with four DTLA IBM disks plugged to a 3ware 
raid card. On recovery, and after some time, one of the volumes started 
complaining about errors, and went into degraded mode. One of the disks was 
clearly broken we thought. So we exchanged it, but alas a couple hours later 
another one in another volume complained. We also exchanged that one and 
rebuilt everything. After checking the disks with IBM drive fitness software both 
presented bad blocks that were recovered with a low level format. I dismissed 
the events as something weird, but with some logical explanation beyond my 
grasp. Now all makes sense.


/Pedro


On 24 Nov 2001 at 20:20, Florian Weimer wrote:

> Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:
> 
> > However, if it's really true that DTLA drives and their successor
> > corrupt blocks (generate bad blocks) on power loss during block
> > writes, these drives are crap.
> 
> They do, even IBM admits that (on
> 
>         http://www.cooling-solutions.de/dtla-faq
> 
> you find a quote from IBM confirming this).  IBM says it's okay, you
> have to expect this to happen.  So much for their expertise in making
> hard disks.  This makes me feel rather dizzy (lots of IBM drives in
> use).
> 
> -- 
> Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
> University of Stuttgart           http://cert.uni-stuttgart.de/
> RUS-CERT                          +49-711-685-5973/fax
> +49-711-685-5898 - To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in the body of a message to
> majordomo@vger.kernel.org More majordomo info at 
> http://vger.kernel.org/majordomo-info.html Please read the FAQ at 
> http://www.tux.org/lkml/
> 



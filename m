Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbTAXDty>; Thu, 23 Jan 2003 22:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTAXDtx>; Thu, 23 Jan 2003 22:49:53 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:33031 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S267526AbTAXDtw>; Thu, 23 Jan 2003 22:49:52 -0500
Date: Thu, 23 Jan 2003 20:56:38 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br
Subject: Re: Aic7xxx 6.2.28 and Aic79xx 1.3.0 Released
Message-ID: <694670000.1043380598@aslan.scsiguy.com>
In-Reply-To: <20030123.193540.113447969.davem@redhat.com>
References: <87730000.1043275833@aslan.btc.adaptec.com>
 	<1043380546.16483.6.camel@rth.ninka.net>
 	<685330000.1043379905@aslan.scsiguy.com>
 <20030123.193540.113447969.davem@redhat.com>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: "Justin T. Gibbs" <gibbs@scsiguy.com>
>    Date: Thu, 23 Jan 2003 20:45:05 -0700
> 
>    > You keep doing this, I wish you'd stop :-)
>    
>    I wish you'd actually look at the changes before assuming
>    what they do and don't contain.
>    
> You deleted my change on at least two occaisions.
> If you've stopped doing that, great.

And when it happened the first time, you didn't bother to tell
me?  Why?  So you could act slighted later?

If you really care to have an update *stick* to a piece of externally
maintained software, pass your changes through the maintainer.  That is
only reasonable.

There have been lots of changes to the driver that I have merged back
manually and lots that I have tossed as incorrect and should never have
been accepted by Linus in the first place.  In your case, the change was
small *and* incomplete (you didn't update the aic79xx driver), so it was
missed during a few of my merges.  If you had simply bothered to send me
email when you submitted the change to Linus (you seem to know my email
address and that I maintain the driver) both drivers would have had this
change long ago.

And yes, both drivers, as of this drop, now include asm/io.h.

--
Justin


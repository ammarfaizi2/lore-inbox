Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbRFNLbu>; Thu, 14 Jun 2001 07:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbRFNLbk>; Thu, 14 Jun 2001 07:31:40 -0400
Received: from the.earth.li ([195.149.39.90]:23045 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id <S262084AbRFNLbe>;
	Thu, 14 Jun 2001 07:31:34 -0400
Date: Thu, 14 Jun 2001 13:31:25 +0200
From: Simon Huggins <huggie@earth.li>
To: Seigneur Angmar <seigneurangmar@hotmail.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Lecteur CD-ROM
Message-ID: <20010614133125.G29611@the.earth.li>
Mail-Followup-To: Simon Huggins <huggie@earth.li>,
	Seigneur Angmar <seigneurangmar@hotmail.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <F89qlOQq2vXqZAmN0oG000027c6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <F89qlOQq2vXqZAmN0oG000027c6@hotmail.com>; from seigneurangmar@hotmail.com on Wed, Jun 13, 2001 at 10:19:03PM -0400
Organization: Black Cat Networks, http://www.blackcatnetworks.co.uk/
X-Attribution: huggie
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One (approximate) translation coming up...

Tu devrais poster en anglais sur une liste anglaise...
J'ai traduit ton message ci-dessous:

On Wed, Jun 13, 2001 at 10:19:03PM -0400, Seigneur Angmar wrote:
>     Je vous décrirai le problème du mieux que je peux.  Avant tout, je tiens 
> à souligner que, sous les mêmes configurations, le problème ne s'est produit 
> et reproduit que sur les kernels 2.4.X (kernels testés : 2.2.18, 2.2.19, 
> 2.4.0, 2.4.3, 2.4.5).

He's having this problem only on 2.4.x kernels having tested 2.2.18,
2.2.19, 2.4.0, 2.4.3, 2.4.5

>     J'ai en ma possession un CD-R (fait sous Windows 98) qui fonctionne sans 
> reproches.  Absolument rien d'anormal ne se produit quand j'écris la ligne 
> suivante : "mount /dev/cdrom".  Le problème survient quand j'essaye de 
> copier un fichier sur le disc dur.  Le message suivant s'affiche :

He's having problems with a CD-R that was burnt under Windows 98 which
he says is known to be good.  Nothing strange happens when he mounts it
with mount /dev/cdrom but when he tries to copy data off it he gets:

> hdb: command error: status=0x51 { DriveReady SeekComplete Error }
> hdb: command error: error=0x54
> end_request: I/O error, dev 03:40 (hdb), sector 14776
> hdb: command error: status=0x51 { DriveReady SeekComplete Error }
> hdb: command error: error=0x54
> end_request: I/O error, dev 03:40 (hdb), sector 14780
> cp: wumpscut - mortal highway.mp3: Input/output error
> ...

> Je rappelle que ce problème n'est jamais arrivé sur aucuns des kernels 2.2.X 
> que j'ai compilé.

And he reiterates that 2.2.x didn't do this.

> N.B. : je possède un ATAPI CDROM: LTN242F

And gives his CDROM model number.

-- 
Simon Huggins  \ "No problem is too big it can't be run away from" --
                \ Linus
http://www.earth.li/~huggie/                                htag.pl 0.0.18

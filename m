Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSGNO6P>; Sun, 14 Jul 2002 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSGNO6O>; Sun, 14 Jul 2002 10:58:14 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25863 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316916AbSGNO6O>; Sun, 14 Jul 2002 10:58:14 -0400
Date: Sun, 14 Jul 2002 12:00:53 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: andersen@codepoet.org, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207141418.g6EEIbJp019125@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44L.0207141200030.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Joerg Schilling wrote:
> >From andersen@codepoet.org Sat Jul 13 07:40:59 2002

> >happen.  For starters, Linux devices don't have to be forced to
> >all be sitting on the SCSI bus.  You could use standard Linux
> >device names (i.e. /dev/hdc or /dev/scd0).  And you could still
> >send all the SCSI/ATAPI packet commands you want to the device
> >that was selected  using the CDROM_SEND_PACKET ioctl.
>
> For a starter, it is easier to understand the SCSI concept of
> addressing than to understand the Linux concept. In addition,
> the SCSI addressing concept can be used on different platforms

The traditional SCSI concept of addressing is not compatible
with SAN style hardware, like iscsi or large fibre channel
setups.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


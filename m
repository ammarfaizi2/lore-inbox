Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSGOJWa>; Mon, 15 Jul 2002 05:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSGOJW2>; Mon, 15 Jul 2002 05:22:28 -0400
Received: from cibs9.sns.it ([192.167.206.29]:11528 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S317400AbSGOJW1>;
	Mon, 15 Jul 2002 05:22:27 -0400
Date: Mon, 15 Jul 2002 11:11:03 +0200 (CEST)
From: venom@sns.it
To: Rik van Riel <riel@conectiva.com.br>
cc: Joerg Schilling <schilling@fokus.gmd.de>,
       <Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
       <andersen@codepoet.org>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <Pine.LNX.4.44L.0207141718130.12241-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.43.0207151108440.12462-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Rik van Riel wrote:

> Date: Sun, 14 Jul 2002 17:18:35 -0300 (BRT)
> From: Rik van Riel <riel@conectiva.com.br>
> To: Joerg Schilling <schilling@fokus.gmd.de>
> Cc: Richard.Zidlicky@stud.informatik.uni-erlangen.de, andersen@codepoet.org,
>      linux-kernel@vger.kernel.org
> Subject: Re: IDE/ATAPI in 2.5
>
> On Sun, 14 Jul 2002, Joerg Schilling wrote:
>
> > BTW: did you ever look at Solaris / HP-UX, ... and the way they
> > name disks?
> >
> > someting like: /dev/{r}dsk/c0t0d0s0
> > This is SCSI bus, target, lun and slice.
>
> I wonder what they'll change it to in order to support
> network attached storage.
>
Actually notthing:

dbtecnocasa:{root}:/>format
Searching for disks...done

c2t1d0: configured with capacity of 6.56MB
c2t1d30: configured with capacity of 34.04GB
c2t1d31: configured with capacity of 34.04GB
c2t1d81: configured with capacity of 34.04GB


AVAILABLE DISK SELECTIONS:
       0. c0t0d0 <SUN18G cyl 7506 alt 2 hd 19 sec 248>
          /pci@1f,4000/scsi@3/sd@0,0
       1. c2t1d0 <EMC-SYMMETRIX-5567 cyl 14 alt 2 hd 15 sec 64>
          /pci@4,2000/scsi@1/sd@1,0
       2. c2t1d30 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
          /pci@4,2000/scsi@1/sd@1,1e
       3. c2t1d31 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
          /pci@4,2000/scsi@1/sd@1,1f
       4. c2t1d81 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
          /pci@4,2000/scsi@1/sd@1,51

except of c0t0d0 everything else is network attached...




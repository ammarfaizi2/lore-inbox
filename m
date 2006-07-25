Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWGYDnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWGYDnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 23:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWGYDnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 23:43:22 -0400
Received: from xenotime.net ([66.160.160.81]:24808 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932421AbWGYDnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 23:43:21 -0400
Date: Mon, 24 Jul 2006 20:46:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matt LaPlante <kernel1@cyberdogtech.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc2] Fix typos in /Documentation : 'H'-'M'
Message-Id: <20060724204605.f239956b.rdunlap@xenotime.net>
In-Reply-To: <20060724192747.da3a9235.kernel1@cyberdogtech.com>
References: <20060724192747.da3a9235.kernel1@cyberdogtech.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006 19:27:47 -0400 Matt LaPlante wrote:

> This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letters 'H'-'M'.  
> 
> diff -ru a/Documentation/input/gameport-programming.txt b/Documentation/input/gameport-programming.txt
> --- a/Documentation/input/gameport-programming.txt	2006-06-17 21:49:35.000000000 -0400
> +++ b/Documentation/input/gameport-programming.txt	2006-07-24 19:05:48.000000000 -0400
> @@ -19,7 +19,7 @@
>  
>  If your hardware supports more than one io address, and your driver can
>  choose which one program the hardware to, starting from the more exotic
                   ^insert: to

> -addresses is preferred, because the likelyhood of clashing with the standard
> +addresses is preferred, because the likelihood of clashing with the standard
>  0x201 address is smaller.
>  
>  Eg. if your driver supports addresses 0x200, 0x208, 0x210 and 0x218, then

> diff -ru a/Documentation/sched-design.txt b/Documentation/sched-design.txt
> --- a/Documentation/sched-design.txt	2006-06-17 21:49:35.000000000 -0400
> +++ b/Documentation/sched-design.txt	2006-07-24 19:05:48.000000000 -0400
> @@ -93,7 +93,7 @@
>  Design
>  ======
>  
> -the core of the new scheduler are the following mechanizms:
> +The core of the new scheduler are the following mechanisms:

s/are/contains/

>   - *two*, priority-ordered 'priority arrays' per CPU. There is an 'active'

drop comma

>     array and an 'expired' array. The active array contains all tasks that

> diff -ru a/Documentation/scsi/ibmmca.txt b/Documentation/scsi/ibmmca.txt
> --- a/Documentation/scsi/ibmmca.txt	2006-06-17 21:49:35.000000000 -0400
> +++ b/Documentation/scsi/ibmmca.txt	2006-07-24 19:05:48.000000000 -0400
> @@ -229,7 +229,7 @@
>  
>     In a second step of the driver development, the following improvement has
>     been applied: The first approach limited the number of devices to 7, far
> -   fewer than the 15 that it could usem then it just maped ldn -> 
> +   fewer than the 15 that it could use, then it just mapped ldn -> 
>     (ldn/8,ldn%8) for pun,lun.  We ended up with a real mishmash of puns
>     and luns, but it all seemed to work.
>  
> @@ -254,12 +254,12 @@
>     device to be existant, but it has no ldn assigned, it gets a ldn out of 7 
>     to 14. The numbers are assigned in cyclic order. Therefore it takes 8 
>     dynamical reassignments on the SCSI-devices, until a certain device 
> -   loses its ldn again. This assures, that dynamical remapping is avoided 
> +   loses its ldn again. This assures that dynamical remapping is avoided 
>     during intense I/O between up to 15 SCSI-devices (means pun,lun 
> -   combinations). A further advantage of this method is, that people who
> +   combinations). A further advantage of this method is that people who
>     build their kernel without probing on all luns will get what they expect,
>     because the driver just won't assign everything with lun>0 when 
> -   multpile lun probing is inactive.
> +   multiple lun probing is inactive.
>   
>     2.4 SCSI-Device Order
>     ---------------------
> @@ -1104,7 +1104,7 @@
>  	The parameter 'normal' sets the new industry standard, starting
>  	from pun 0, scanning up to pun 6. This allows you to change your 
>  	opinion still after having already compiled the kernel.
> -     Q: Why I cannot find the IBM MCA SCSI support in the config menue?
> +     Q: Why I cannot find the IBM MCA SCSI support in the config menu?

        Q: Why can I not find ...?
or
        Q: Why can't I find ...?

>       A: You have to activate MCA bus support, first.
>       Q: Where can I find the latest info about this driver?
>       A: See the file MAINTAINERS for the current WWW-address, which offers

Rest look good to me.

Thanks,
---
~Randy

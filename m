Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136800AbRECMwz>; Thu, 3 May 2001 08:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136801AbRECMwp>; Thu, 3 May 2001 08:52:45 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:45063 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S136800AbRECMwa>; Thu, 3 May 2001 08:52:30 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nikolas Zimmermann <wildfox@kde.org>
To: =?iso-8859-1?q?s=E9bastien=20person?= 
	<sebastien.person@sycomore.fr>
Subject: Re: NEWBEE "reverse ioctl" or someting like
Date: Thu, 3 May 2001 14:51:26 +0200
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <20010503142929.773147bf.sebastien.person@sycomore.fr>
In-Reply-To: <20010503142929.773147bf.sebastien.person@sycomore.fr>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <14vIaz-1TU3oOC@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 May 2001 14:29, sébastien person wrote:
> hi,
>
> I've made a network driver wich is attached to the serial port.
> The network hardware is able to return information to the pc. theses
> informations are belong to the configuration of the hardware. I
yes yes all your base are belong to us :)
> succeed on receive information in the driver but I've no idea to alert
> higher process (like configuration app ...) that I've received something
> (wich is not network data like TCP or ARP etc ...).
>
> I think that use of pipe isn't preconised because I must fork process
> to use pipe, I search something like ioctl but in the other way :
>
>  kernel process ---> user process
>
> Is somebody know the best and easy way ??
copy_to_user ?
>
> thank (I hope this is the right place to ask)
>
> sebastien person
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Bye
 Bye
  Niko

-- 
Nikolas Zimmermann
wildfox@kde.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280133AbRJaKNx>; Wed, 31 Oct 2001 05:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280134AbRJaKNn>; Wed, 31 Oct 2001 05:13:43 -0500
Received: from cs142038.pp.htv.fi ([213.243.142.38]:56975 "EHLO
	limbo.dnsalias.org") by vger.kernel.org with ESMTP
	id <S280133AbRJaKNd>; Wed, 31 Oct 2001 05:13:33 -0500
Date: Wed, 31 Oct 2001 12:14:05 +0200 (EET)
From: Timo Jantunen <jeti@iki.fi>
To: Mark Atwood <mra@pobox.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Identify IDE device?
In-Reply-To: <m3pu74k4v5.fsf@khem.blackfedora.com>
Message-ID: <Pine.LNX.4.33.0110311212460.1265-100000@limbo.dnsalias.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Oct 2001, Mark Atwood wrote:

> Is there a way, via an ioctl call, or something to identify what
> specific IDE hard disk or other IDE device is hooked up to the IDE
> controller?
> 
> I'm really hoping to be able to determine something like "/dev/hda is
> a Maxtor 96147H6".

Something like
---cut
12:12:17 limbo ~$ cat /proc/ide/hd?/model
IC35L040AVER07-0
IBM-DTLA-307030
TOSHIBA DVD-ROM SD-M1212
CR-4804TE
12:12:19 limbo ~$
---cut
?


// /
....................................Timo Jantunen  ......................
       ZZZ      (Used to represent :Kuunsäde 8 A 28: Email: jeti@iki.fi :
the  sound of  a person  snoring.) :02210 Espoo    : http://iki.fi/jeti :
Webster's  Encyclopedic Unabridged :Finland        : GSM+358-40-5763131 :
Dictionary of the English Language :...............:....................:


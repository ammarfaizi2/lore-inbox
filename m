Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289556AbSBNCf5>; Wed, 13 Feb 2002 21:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289568AbSBNCfs>; Wed, 13 Feb 2002 21:35:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61188 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289556AbSBNCfh>;
	Wed, 13 Feb 2002 21:35:37 -0500
Message-ID: <3C6B2277.CA9A0BF8@mandrakesoft.com>
Date: Wed, 13 Feb 2002 21:35:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petro <petro@auctionwatch.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Eepro100 driver.
In-Reply-To: <20020213211639.GB2742@auctionwatch.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petro wrote:
> 
>     I'm a little confused about the status of the EEPro100 driver.
> 
>     The version in the current kernel has 2 version numbers, and 2
>     dates:
> 
>     v1.09j-t 9/29/99 Donald Becker
>     and
>      $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
> 
>      While the driver available at
>      http://www.scyld.com/network/eepro100.html has a version and date
>      of v1.19 12/19/2001.
> 
>      A couple questions:
> 
>      (1) Has this driver code "forked"?

Yes, a long time ago


>      (2) Is there a technical reason that Mr. Beckers version is not
>      being kept up to date?

No, a political one, Mr. Becker doesn't like us :)  He has refused to
send patches for any kernel, for a long time now.


>      (3) We are experiencing a slight problem with the current version
>      ( eth1: card reports no resources.) that is supposedly fixed in
>      v1.19. Are there plans to integrate the current v1.19 into the main
>      line?

No.  His fix is not "the right one".  There is a gentleman at Sun with
access to the eepro100 documentation, Steve Parker, who has kindly lent
us his brain and time to fix up the driver.

Long term, it is going to be replaced with e100 from Intel, as soon as
that driver is in good shape.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274836AbTGaREJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274845AbTGaREJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:04:09 -0400
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:1986 "EHLO
	renegade") by vger.kernel.org with ESMTP id S274836AbTGaRDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:03:55 -0400
Date: Thu, 31 Jul 2003 10:03:45 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: "Ata, John" <John.Ata@DigitalNet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: incompatible open modes
Message-ID: <20030731170345.GJ6693@renegade>
References: <6DED202D454D3B4EB7D98A7439218D610C9AB7@vahqex2.gfgsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6DED202D454D3B4EB7D98A7439218D610C9AB7@vahqex2.gfgsi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

The best place to ask is on the linux-kernel mailing list (CCed).

Good luck,
Zack

On Thu, Jul 31, 2003 at 12:09:14PM -0400, Ata, John wrote:
>    Hi Zach,
> 
>    I don't know if you're the right contact... just wondered how I go about
>    getting information as to the intent of the Linux kernel... the manpage on
>    "open" states that if a file is opened "O_RDONLY|O_TRUNC", the O_TRUNC is
>    either ignored or an error is returned.  The 2.4 kernel appears to
>    cheerfully truncate the file on open.  I wondered which behavior is
>    actually intended.
> 
>    Thanks for your time...
> 
>    Take care,
>    ------
>    John G. Ata
>    DigitalNet, LLC
>    XTS-400 Software Development
>    MailTo:John.Ata@DigitalNet.com
>    Phone:(703) 563-8092
> 
>    O_TRUNC
>                  If the file already exists and is a regular file  and  the 
>    open
>                  mode  allows  writing  (i.e.,  is O_RDWR or O_WRONLY) it
>    will be
>                  truncated to length 0.  If the file is a FIFO or terminal
>    device
>                  file,  the  O_TRUNC  flag  is  ignored.  Otherwise the
>    effect of
>                  O_TRUNC is unspecified.  (On many  Linux  versions  it 
>    will  be
>                  ignored; on other versions it will return an error.)

-- 
Zack Brown

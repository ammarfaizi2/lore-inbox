Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272589AbRHaCbs>; Thu, 30 Aug 2001 22:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272590AbRHaCbi>; Thu, 30 Aug 2001 22:31:38 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:10759 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S272589AbRHaCbc>; Thu, 30 Aug 2001 22:31:32 -0400
Date: Fri, 31 Aug 2001 04:31:44 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Andreas Franck <afranck@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Messages "ACPI attempting to access kernel owned memory"?
Message-ID: <20010831043143.A811@gondor.com>
In-Reply-To: <E15cZ5F-0001qR-00@the-village.bc.nu> <01083103560000.00925@dg1kfa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01083103560000.00925@dg1kfa>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2001 at 03:56:00AM +0200, Andreas Franck wrote:
> So the solution was not to use a mem commandline. I have not found a way to 
> tell GRUB it should not pass this option, so this should be fixed in GRUB.

the option you are looking for is --no-mem-option in grubs menu.lst.
For example:
kernel --no-mem-option (hd0,2)/boot/latest-kernel root=/dev/hda3

Jan


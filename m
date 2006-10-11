Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030574AbWJKQHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030574AbWJKQHq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWJKQHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:07:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:35873 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030574AbWJKQHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:07:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=E3od7NZ2sHYucjRMfZFrLWAr3iMx43pp5CpJN1uNSXya1VAEJ5SwzNQCh8+6QdYzTzq/qwvQAWckM54nuYihG6/zlDLz25aL3ry4A+/oiZ5POeLi0eRZa3UGS3FjeDWWijrE4TU2L4bQSPELJfr/N/bR6VPs6VmksvHbaa0nuMU=
Message-ID: <6278d2220610110907x3ad7507aya3a12177239accce@mail.gmail.com>
Date: Wed, 11 Oct 2006 17:07:43 +0100
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: "Martin Naskovski" <skopje@freeshell.org>
Subject: Re: Intel 965 chipset motherboards + SATA
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Naskovski wrote:
> I have an ASUS P5B Deluxe/Core 2 Duo/Intel 965/all SATA (Plextor DVD+
> Seagate HD) configuration setup - and as of now, no distribution out there
> can install on this configuration.

I found Ubuntu 6.0.6.1 [1] to support all the hardware of my Asus
P5B-VM (uATX variant) w/ Core2Duo E6400 etc out the box, apart from
the JMicron PATA+SATA+eSATA controller; use the southbridge ICH8 SATA
controller instead.

Seems a solid platform, just note that most DDR2-800 memory is spec'd
to run at 2.0v rather than the 1.8v, so be sure to set this in the
BIOS (defaults to 1.8v of course). I was experiencing intermittent,
silent corruption with large changing patterns in memory @ 1.8v, but
fine at 2.0v with my OCZ DDR2-800.

> Information on whether this issue has been fixed is, at best, dubious on
> various Linux forums.
>
> /Does/ the Linux kernel support this configuration? Can it
> install/recognize this hardware configuration?
>
> I'm sorry to ask this question here, but all I need is a correct answer -
> I've never posted here to ask questions, but this issue has been bugging
> me quite a bit.

--- [1]

http://ubuntu-releases.cs.umn.edu/6.06/ubuntu-6.06.1-desktop-amd64.iso
-- 
Daniel J Blueman

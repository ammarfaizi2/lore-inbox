Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271739AbRHUQjZ>; Tue, 21 Aug 2001 12:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRHUQjP>; Tue, 21 Aug 2001 12:39:15 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:54505 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S271739AbRHUQjD>;
	Tue, 21 Aug 2001 12:39:03 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZDQd-00085r-00@the-village.bc.nu>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 Aug 2001 18:39:04 +0200
In-Reply-To: Alan Cox's message of "Tue, 21 Aug 2001 16:26:55 +0100 (BST)"
Message-ID: <d3itfh8j13.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> If the firmware was out of date, update it to a known "Qlogic stamp
>> of approval" version.

Alan> That requires sorting licensing out with Qlogic. I've talked to
Alan> them usefully about other stuff so I'll pursue it for a seperate
Alan> firmware loader module.

Well getting firmware out of them tends to be up and down.

However I just looked through the QLogic v4.27 provided driver from
their web site and it does in fact included firmware with a GPL
license.

Dave, if you want to play with this and stick it into the qlogicfc.c
driver then you will at least have something that sorta works for now
(module all the other problems with that driver).

http://www.qlogic.com/bbs-html/csg_web/adapter_pages/driver_pages/22xx/22linux.html

They do have a stupid 'read and agree' license in front of that page
if you go in via the official qlogic.com door, however if the code
inside is GPL then I asume it's GPL.

Cheers
Jes

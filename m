Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbTJGSdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbTJGSdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:33:00 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:24456 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP id S262553AbTJGSc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:32:59 -0400
Date: Tue, 7 Oct 2003 19:31:11 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@einstein31.homenet
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [2.4.XX] Silicon Image/CMD Medley Software RAID
In-Reply-To: <22655142.1065544690402.JavaMail.www@wwinf3005>
Message-ID: <Pine.LNX.4.44.0310071928190.554-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003 tigran@aivazian.fsnet.co.uk wrote:

> > 
> > drivers/ide/pci/siimage.c
> > Did you forget to compile it? :-)
> > 
> 
> Yes, you are right! :)
> 
> Thank you! If I am silent that means I went home, compiled the driver
> and my card now works fine at 20M/s. Otherwise I will let you (and everyone)
> know.

Just to confirm:

a) the reason I didn't notice siimage native driver is because I was using 
2.4.20 and it's not there.

b) with 2.4.22 it works! And I get 54M/s on one drive and 38M/s on 
another, which is a lot faster than my onboard IDE controller.

Now, let's hope that ide-scsi subsystem (and thus my DVD writer) still 
work with 2.4.22. I heard some problems about ide-scsi on 2.4.22...

Kind regards
Tigran


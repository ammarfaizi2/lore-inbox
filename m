Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317221AbSFFWOw>; Thu, 6 Jun 2002 18:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317222AbSFFWOv>; Thu, 6 Jun 2002 18:14:51 -0400
Received: from wotug.org ([194.106.52.201]:24162 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S317221AbSFFWOu>;
	Thu, 6 Jun 2002 18:14:50 -0400
Date: Thu, 6 Jun 2002 23:14:43 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: Dag Nygren <dag@newtech.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Devfs strangeness in 2.4.18
In-Reply-To: <20020606205727.18760.qmail@dag.newtech.fi>
Message-ID: <Pine.LNX.4.44.0206062312530.16968-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002, Dag Nygren wrote:

>The problems are tha the sg? links doesn't correspond to the real
>devices shown by /proc/scsi/scsi (Which matches the real situation)
>sg0 matches the first disk, OK
>sg1 matches the Medium changer, OK
>sg2 matches nothing...... There is no target 2 on host1 !!!
>sg3 matches the DLT tape drive
>sg4 matches the DAT tape drive
>
>The other problem is the st? links.
>st0 is linked out into nothing ...
>
>Seems like 3 host adapters is too much for devfs......
>Do I need an upgrade ?

In my experience, devfs doesn't create /dev/sg or /dev/st softlinks. The only 
links it creates are from /dev/discs/... to /dev/ide/... or /dev/scsi/... as 
appropriate.

I would look into the mandrake boot sequence in detail.

Ruth


-- 
Ruth Ivimey-Cook
Software engineer and technical writer.


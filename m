Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274746AbRJQGS6>; Wed, 17 Oct 2001 02:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273269AbRJQGSs>; Wed, 17 Oct 2001 02:18:48 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:60934 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S274746AbRJQGSe>; Wed, 17 Oct 2001 02:18:34 -0400
Date: Wed, 17 Oct 2001 08:18:37 +0200
From: Jens Axboe <axboe@suse.de>
To: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: "Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Problem with 2.4.14prex and qlogicfc
Message-ID: <20011017081837.C3035@suse.de>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D570@xfc01.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D570@xfc01.fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16 2001, DICKENS,CARY (HP-Loveland,ex2) wrote:
> Hi folks,
> 
> I'm seeing a problem on all the kernels that are 2.4.13pre1 and up.  I've
> lost the ability to communicate to my storage through some qlogic 2200 fibre
> channel cards.  All the disks are identified and given over to devices. The
> problem occurs when you attempt to write to the disks.  The system prints
> out that the link is up, but will not move from there.  The system becomes
> unresponsive to the keyboard.  Up to 2.4.12 works ok (I'm putting together
> some comparative numbers), and the current ac tree is working correctly as
> well.
> 
> I saw this behavior with 2.4.10 and the bounce memory patch by Jens Axboe,
> but attributed it to operator error.  I'm less sure now. 
> 
> Any ideas about what is going on would be appreciated.  I know this is a
> sketchy description, but I'm hoping someone else has seen it too and can
> help me get closer to a resolution.

This smells like a bug in the pci64 conversion of qlogicfc. Maybe davem
has an idea, I'll take a look too.

BTW, I'd love to see no-bounce numbers for this setup once this bug is
resolved!

-- 
Jens Axboe


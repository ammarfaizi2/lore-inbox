Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSEELwU>; Sun, 5 May 2002 07:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSEELwT>; Sun, 5 May 2002 07:52:19 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:39688 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S310769AbSEELwT>; Sun, 5 May 2002 07:52:19 -0400
Message-Id: <200205051149.g45BnGX13620@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Tomas Szepe <szepe@pinerecords.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>
Subject: Re: IO stats in /proc/partitions
Date: Sun, 5 May 2002 14:55:03 -0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <UTC200205041959.g44JxQa20044.aeb@smtp.cwi.nl> <HBEHIIBBKKNOBLMPKCBBCEAOEMAA.znmeb@aracnet.com> <20020504213534.GA3034@louise.pinerecords.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 May 2002 19:35, Tomas Szepe wrote:
> > I recently spent a week trying to track down the units used for the disk
> > stats in /proc/stat. Through a combination of queries on the LKML and
> > trucking through the source with rgrep, I managed to get my questions
> > answered. It matters to me and to the people I work for exactly how many
> > bytes the I/O subsystem is handling per second, and how close to the
> > capacity of the I/O subsystem a machine is operating. I consider the fact
> > that I had to dig for and ask for this information unacceptable.
>
> But hey, you've suffered thru it, which, guess what, makes you the perfect
> candidate to have the honor of writing the docs!

And peppering code with cute little comments + feeding patches to Rusty's
'trivial' patchbot.

BTW, are units consistent? Kilobytes? Pages? Sectors?
--
vda

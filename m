Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284950AbRL0Sv2>; Thu, 27 Dec 2001 13:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286472AbRL0SvT>; Thu, 27 Dec 2001 13:51:19 -0500
Received: from ns.ithnet.com ([217.64.64.10]:31504 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S284950AbRL0SvI>;
	Thu, 27 Dec 2001 13:51:08 -0500
Date: Thu, 27 Dec 2001 19:51:01 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "James Stevenson" <mistral@stev.org>
Cc: jlladono@pie.xtec.es, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x kernels, big ide disks and old bios
Message-Id: <20011227195101.5bf120f9.skraw@ithnet.com>
In-Reply-To: <000701c18ed8$73f2b2d0$0801a8c0@Stev.org>
In-Reply-To: <3C285B40.91A83EC7@jep.dhis.org>
	<001a01c18d77$a9e92ca0$0801a8c0@Stev.org>
	<20011226173307.34e25fe6.skraw@ithnet.com>
	<000701c18ed8$73f2b2d0$0801a8c0@Stev.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001 13:14:43 -0000
"James Stevenson" <mistral@stev.org> wrote:

> > I tried this one some time ago, and had to find out, that I was not able
> to
> > write to the upper cylinders of the disk. You can check this out _before_
> using
> > the drive via dd from /dev/zero to your /dev/drive and look at the
> results.
> 
> it seems to work fine for me.
> could it be possible that the chipset that you are using does not support
> disks bigger than 32GB ?

I don't know. I tried once with

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)

and it did not work. I could definitely not write beyond the 32 GB border. I
replaced the mobo then.

Regards,
Stephan


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313916AbSEFAXY>; Sun, 5 May 2002 20:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313925AbSEFAXX>; Sun, 5 May 2002 20:23:23 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43248
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313916AbSEFAXX>; Sun, 5 May 2002 20:23:23 -0400
Date: Sun, 5 May 2002 17:23:05 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Conway <nconway_kernel@yahoo.co.uk>, Andrew Morton <akpm@zip.com.au>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH, IDE corruption, 2.4.18
Message-ID: <20020506002305.GI2392@matchmail.com>
Mail-Followup-To: Neil Conway <nconway_kernel@yahoo.co.uk>,
	Andrew Morton <akpm@zip.com.au>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0205051741140.23671-100000@mion.elka.pw.edu.pl> <20020505204431.74013.qmail@web21501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2002 at 09:44:31PM +0100, Neil Conway wrote:
>  Also, does anyone understand why screwing up a DMA transfer results in
> the trashing of inodes?  Even better, how come this hasn't bitten many
> more people?  Surely there are lots of people out there with disks and
> CDs on the same IDE cable...
> 
> Neil
> (PS: I have reproduced the problem on two systems so far.)

That seems to be a seperate problem with the block layer and locked buffers
or pages (don't remember which).

I think a patch was submitted and integrated sometime in 2.4.19-pre.  Andrew
Morton would know more.

Mike

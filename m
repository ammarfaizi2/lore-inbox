Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284601AbRLPLmS>; Sun, 16 Dec 2001 06:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284599AbRLPLmJ>; Sun, 16 Dec 2001 06:42:09 -0500
Received: from [213.97.199.90] ([213.97.199.90]:6016 "HELO fargo")
	by vger.kernel.org with SMTP id <S284596AbRLPLlx> convert rfc822-to-8bit;
	Sun, 16 Dec 2001 06:41:53 -0500
From: "David Gomez" <davidge@jazzfree.com>
Date: Sun, 16 Dec 2001 12:41:11 +0100 (CET)
X-X-Sender: <huma@fargo>
To: Dave Jones <davej@suse.de>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
In-Reply-To: <Pine.LNX.4.33.0112160458500.15956-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0112161231570.650-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Dec 2001, Dave Jones wrote:

> > I'm using kernel 2.4.17-rc1 and found what i think is a bug, maybe related
> > to the loop device. This is the situation:
>
> Can you repeat it with this applied ?
> ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc1aa1/00_loop-deadlock-1

Thanks ;), this patch solves the problem and copying a lot of data to the
loop device now doesn't hang the computer.

Is this patch going to be applied to the stable kernel ? Marcelo ?



David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281274AbRKPK1g>; Fri, 16 Nov 2001 05:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281285AbRKPK11>; Fri, 16 Nov 2001 05:27:27 -0500
Received: from ultra02.rbg.informatik.tu-darmstadt.de ([130.83.9.52]:24482
	"EHLO mail.rbg.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id <S281274AbRKPK1J>; Fri, 16 Nov 2001 05:27:09 -0500
Date: Fri, 16 Nov 2001 11:26:14 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [OOPS] net/8139too
Message-ID: <20011116112614.A725@walker.iti.informatik.tu-darmstadt.de>
Reply-To: pmhahn@titan.lahn.de
In-Reply-To: <Pine.LNX.4.33.0111160721120.6043-100000@titan.lahn.de> <3BF4BD81.C3E4A4DC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3BF4BD81.C3E4A4DC@zip.com.au>; from akpm@zip.com.au on Fri, Nov 16, 2001 at 08:17:21 +0100
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew, Jedd, LKML!

On 2001.11.16 08:17 Andrew Morton wrote:
> > Since linux-2.4.15-pre[14]+kdb+freeswan I get an oops when stopping my
> > 8139too network:
> >
> > # ifdown eth0
> > eth0: unable to signal thread
> 
> Could you please tell us what the return value is from kill_proc()?
Now running 2.4.15-pre5 with your patch and kill_proc returns -3.

Willing to test more patches.

BYtE
Philipp
-- 
   / /  (_)__  __ ____  __ Philipp Hahn
  / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

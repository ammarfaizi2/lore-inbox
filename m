Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144202AbRA1Vg1>; Sun, 28 Jan 2001 16:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143630AbRA1VgR>; Sun, 28 Jan 2001 16:36:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19979 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S144202AbRA1VgE>; Sun, 28 Jan 2001 16:36:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Renaming lost+found
Date: 28 Jan 2001 13:35:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9523bg$7dc$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1010126084632.208A-100000@chaos.analogic.com> <3A73565B.6EBC7F77@ngforever.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A73565B.6EBC7F77@ngforever.de>
By author:    Thunder from the hill <thunder@ngforever.de>
In newsgroup: linux.dev.kernel
>
> > A file-system without a lost+found directory is like love without sex.
> You mean, possible but leaving you unsatisfied? Well, I think a file
> system without a lost+found is a lot worse.
> 

Hello people... the original question was: can lost+found be
*renamed*, i.e. does the tools (e2fsck &c) use "/lost+found" by name,
or by inode?  As far as I know it always uses the same inode number
(11), but I don't know if that is anywhere enforced.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131945AbQKJWUO>; Fri, 10 Nov 2000 17:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbQKJWUF>; Fri, 10 Nov 2000 17:20:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34566 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131945AbQKJWT6>; Fri, 10 Nov 2000 17:19:58 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Date: 10 Nov 2000 14:19:45 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uhsa1$2il$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1001110153916.6334A-100000@chaos.analogic.com> <3A0C5EDC.3F30BE9C@timpanogas.org> <20001110125902.A16027@sendmail.com> <00111023290401.00203@linux1.home.bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <00111023290401.00203@linux1.home.bogus>
By author:    Davide Libenzi <davidel@xmail.virusscreen.com>
In newsgroup: linux.dev.kernel
>
> On Fri, 10 Nov 2000, Claus Assmann wrote:
> > On Fri, Nov 10, 2000, Jeff V. Merkey wrote:
> > > Looks like your bug.  As an FYI, sendmail.rpms in Suse, RedHat, and
> > > OpenLinux all exhibit this behavior, which means they're all broken. 
> > 
> > Sorry, this is plain wrong. sendmail does NOT read the entire
> > file into memory.
> 
> Does sendmail use sendfile() ?
> 

Or mmap()/write()?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129445AbRAaKqq>; Wed, 31 Jan 2001 05:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAaKqg>; Wed, 31 Jan 2001 05:46:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25862 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129445AbRAaKqS>; Wed, 31 Jan 2001 05:46:18 -0500
Subject: Re: hotmail not dealing with ECN
To: hpa@transmeta.com (H. Peter Anvin)
Date: Wed, 31 Jan 2001 10:46:40 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org
In-Reply-To: <3A70D7B2.F8C5F67C@transmeta.com> from "H. Peter Anvin" at Jan 25, 2001 05:49:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Numh-00026h-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > RFC793, where is lists the unused flag bits as "reserved".
> > That is pretty clear to me.  It just has to say that
> > they are reserved, and that is what it does.
> > 
> 
> Is the definition of "reserved" defined anywhere?  In a lot of specs,
> "reserved" means MBZ.
> 
> Note, that I'm not arguing with you.  I'm trying to pick this apart.

Reserved values are normally (as in 793) listed as reserved, must be zero.
The meaning of that in RFC literature is absolutely clear. That in the absence
of you supporting a newer feature using these bits the value must be set to
zero. You may not rely on it being zero from another host however.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

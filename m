Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289056AbSANVHc>; Mon, 14 Jan 2002 16:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSANVF5>; Mon, 14 Jan 2002 16:05:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35592 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289046AbSANVFf>; Mon, 14 Jan 2002 16:05:35 -0500
Subject: Re: Memory problem with bttv driver
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 14 Jan 2002 21:17:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020114210039.180c0438.skraw@ithnet.com> from "Stephan von Krawczynski" at Jan 14, 2002 09:00:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QETz-0002yD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. So what do we do about it? I mean there are possibly some more people out
> there with such a problem, or - to my prediction - there will be more in the
> future. I see to possibilities:
> 1) simply increase it overall. I have not the slightest idea what the drawbacks
> are. 2) make it configurable (looks like general setup to me).

Making it bigger reduces that amount of ram directly mapped by the kernel 
which hits performance (nastily for 2.4 not so bad for 2.5)

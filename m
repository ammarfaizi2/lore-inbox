Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132625AbRC2AMh>; Wed, 28 Mar 2001 19:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132626AbRC2AMR>; Wed, 28 Mar 2001 19:12:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7587 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132625AbRC2AMO>;
	Wed, 28 Mar 2001 19:12:14 -0500
Message-ID: <3AC27DB3.C2E20FC5@mandrakesoft.com>
Date: Wed, 28 Mar 2001 19:11:31 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Passos <lists@cyclades.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
   Daniela Magri <daniela@cyclades.com>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <Pine.LNX.4.30.0103281558140.15795-100000@intra.cyclades.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos wrote:
> Maybe it's a better idea to have just two ioctl's here (GET and SET), and
> have "subioctl's" inside the structure passed to the HDLC layer (and
> defined by the HDLC layer). This would allow changes in the HDLC layer
> without having to change sockios.h (you'd still have to change HDLC's
> code and definitions, but this would be more self-contained). Again, this
> may be better, or maybe not. What do you think?

That's essentially what's happening with ethtool
(include/linux/ethtool.h in 2.4.3-pre8)

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278986AbRKAO2w>; Thu, 1 Nov 2001 09:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279005AbRKAO2m>; Thu, 1 Nov 2001 09:28:42 -0500
Received: from toad.com ([140.174.2.1]:23309 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278986AbRKAO2d>;
	Thu, 1 Nov 2001 09:28:33 -0500
Message-ID: <3BE15BF0.C6FB873C@mandrakesoft.com>
Date: Thu, 01 Nov 2001 09:28:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: driver initialisation order problem
In-Reply-To: <20011101141412.R20398@redhat.com> <3BE15A85.8B9DF165@mandrakesoft.com> <20011101142544.T20398@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Thu, Nov 01, 2001 at 09:21:57AM -0500, Jeff Garzik wrote:
> 
> > I would move lp to parport, since IMHO it belongs there anyway.
> 
> It isn't confined to just lp:
> 
> $ grep -l parport $(find drivers/char -name '*.c')
> drivers/char/lp.c
> drivers/char/ppdev.c

I would move both of these to parport


> drivers/char/joystick/turbografx.c
> drivers/char/joystick/db9.c
> drivers/char/joystick/gamecon.c

don't have a good answer.  maybe move 'em to drivers/input :)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

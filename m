Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbRETObR>; Sun, 20 May 2001 10:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbRETObH>; Sun, 20 May 2001 10:31:07 -0400
Received: from smtp2.libero.it ([193.70.192.52]:5828 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S261619AbRETOa7>;
	Sun, 20 May 2001 10:30:59 -0400
Message-ID: <3B07D519.5184BFA@alsa-project.org>
Date: Sun, 20 May 2001 16:30:49 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <Pine.GSO.4.21.0105200925370.8940-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On 20 May 2001, Kai Henningsen wrote:
> 
> > I've seen this question several times in this thread. I haven't seen the
> > obvious answer, though.
> >
> > Have a new system call:
> >
> > ctlfd = open_device_control_fd(fd);
> > If fd is something that doesn't have a control interface (say, it already
> > is a control filehandle), this returns an appropriate error code.
> 
> It may have several. Which one?

Can you explain better this?

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

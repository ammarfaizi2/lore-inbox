Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130037AbRCDM5g>; Sun, 4 Mar 2001 07:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130045AbRCDM51>; Sun, 4 Mar 2001 07:57:27 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:59406 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S130037AbRCDM5M>;
	Sun, 4 Mar 2001 07:57:12 -0500
Message-ID: <20010304135712.A24990@win.tue.nl>
Date: Sun, 4 Mar 2001 13:57:12 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Pavel Machek <pavel@suse.cz>,
        Sébastien HINDERER <jrf3@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard simulation
In-Reply-To: <3a9cc5953b575371@citronier.wanadoo.fr> <20010301124158.E34@(none)> <20010303001450.A22847@win.tue.nl> <20010304124014.C217@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010304124014.C217@bug.ucw.cz>; from Pavel Machek on Sun, Mar 04, 2001 at 12:40:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2001 at 12:40:14PM +0100, Pavel Machek wrote:

> > > Transmit keycodes is AFAIK not implemented in official drivers.
> > 
> > Maybe I misunderstand what you mean, but the kernel has had a
> > keycode mode since before 1.0.
> 
> I meant ability for application to simulate pressing "shift" or
> "pageup". I do not believe we have that feature.

No. But we have TIOCSTI, which will do this in raw scancode mode.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263780AbRF0Pjk>; Wed, 27 Jun 2001 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263766AbRF0Pja>; Wed, 27 Jun 2001 11:39:30 -0400
Received: from freerunner-o.cendio.se ([193.180.23.130]:27893 "EHLO
	mail.cendio.se") by vger.kernel.org with ESMTP id <S263340AbRF0PjO>;
	Wed, 27 Jun 2001 11:39:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User chroot
In-Reply-To: <20010627014534.B2654@ondska> <9hb6rq$49j$1@cesium.transmeta.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 27 Jun 2001 17:39:12 +0200
In-Reply-To: hpa@zytor.com's message of "26 Jun 2001 16:46:02 -0700"
Message-ID: <ve4rt2aq5b.fsf@lipta.lkpg.cendio.se>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@zytor.com ("H. Peter Anvin") writes:

> Followup to:  <20010627014534.B2654@ondska>
> By author:    Jorgen Cederlof <jc@lysator.liu.se>
> In newsgroup: linux.dev.kernel
> > If we only allow user chroots for processes that have never been
> > chrooted before, and if the suid/sgid bits won't have any effect under
> > the new root, it should be perfectly safe to allow any user to chroot.
> 
> Safe, perhaps, but also completely useless: there is no way the user
> can set up a functional environment inside the chroot.

Huh? Why wouldn't you be able to set up a functional environment?
I can think of quite a lot of things you can do without device nodes
or /proc ...
Or are you referring to something else?

//Marcus
-- 
---------------------------------+---------------------------------
         Marcus Sundberg         |      Phone: +46 707 452062
   Embedded Systems Consultant   |     Email: marcus@cendio.se
        Cendio Systems AB        |      http://www.cendio.com

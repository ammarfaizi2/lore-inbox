Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280084AbRKEBEc>; Sun, 4 Nov 2001 20:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280086AbRKEBEW>; Sun, 4 Nov 2001 20:04:22 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:18188 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S280084AbRKEBEK>;
	Sun, 4 Nov 2001 20:04:10 -0500
Date: Mon, 5 Nov 2001 02:04:08 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Special Kernel Modification
Message-ID: <20011105020408.A6862@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BE5D6EC.8040204@outstep.com> <E160XU3-00012T-00@localhost> <1004920141.3be5dd4db68a0@mail.outstep.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1004920141.3be5dd4db68a0@mail.outstep.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-04 19:29:01 -0500, lonnie@outstep.com <lonnie@outstep.com>
wrote in message <1004920141.3be5dd4db68a0@mail.outstep.com>:
> The basic problem is that I did not want, for example "user2" to be able to "cd
> .." or some thing to go out of user2
> 
> I was hoping to be able to accomplish this at the filesystem level somehow, and
> possibly without the need to mount the /dev/hda4 onto each /home/user/system, or
> without having to make entire copies of the chrooted environment for each user.

Isn't it the simplest of all to set all the user's file and directory
modes to sth likt 0700? Then, every user may only access his/her
files. (S)he cannot look at other user's files.

MfG, JBG

-- 
Jan-Benedict Glaw . jbglaw@lug-owl.de . +49-172-7608481

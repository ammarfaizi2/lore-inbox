Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVCJJZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVCJJZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVCJJZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:25:05 -0500
Received: from 62-177-247-250.dyn.bbeyond.nl ([62.177.247.250]:1807 "EHLO
	www.ithos.nl") by vger.kernel.org with ESMTP id S262451AbVCJJZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:25:00 -0500
Date: Wed, 9 Mar 2005 23:40:27 +0100 (CET)
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
X-X-Sender: rbultje@www.ithos.nl
To: Jean Delvare <khali@linux-fr.org>
cc: Chris Wright <chrisw@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Daniel Staaf <dst@bostream.nu>, LKML <linux-kernel@vger.kernel.org>,
       Andrei Mikhailovsky <andrei@arhont.com>,
       Ian Campbell <icampbell@arcom.com>, Gerd Knorr <kraxel@bytesex.org>,
       stable@kernel.org
Subject: Re: [PATCH 2.6] Fix i2c messsage flags in video drivers
In-Reply-To: <20050309225559.061058dd.khali@linux-fr.org>
Message-ID: <Pine.LNX.4.56.0503092336240.16415@www.ithos.nl>
References: <1110024688.5494.2.camel@whale.core.arhont.com> <422A5473.7030306@osdl.org>
 <1110115990.5611.2.camel@whale.core.arhont.com> <422CCBF4.1060902@osdl.org>
 <20050308201504.6aee36d5.khali@linux-fr.org> <20050308202530.2fbfae9a.khali@linux-fr.org>
 <20050309184055.GX28536@shell0.pdx.osdl.net> <20050309225559.061058dd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

I'm sorry for a late reply, mail is (still) misbehaving. I hope this
arrives at all...

On Wed, 9 Mar 2005, Jean Delvare wrote:
> It is possible that people are able to get their board to still work
> without my patch, if the chips were properly configured in the first
> place and they don't attempt to reconfigure them (like norm change). I
> don't know the chips well enough to tell how probable this is.

I'm pretty sure the patch is correct, I trust you a lot more on that than
myself (I still need to test it, though; but that's a detail). However,
this statement is not correct. I test this driver daily, I still own a
whole bunch of such cards. Even after hard reboots, they still just work.
Norm changes, input changes, everything works. I test (and use) all of
this. I would've noticed if it was really as broken as you're describing
above.

Ronald

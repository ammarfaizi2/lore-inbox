Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbWGJOCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWGJOCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWGJOCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:02:20 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:51384 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030356AbWGJOCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:02:19 -0400
Date: Mon, 10 Jul 2006 16:02:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Albert Cahalan <acahalan@gmail.com>
cc: ray-gmail@madrabbit.org, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: Opinions on removing /proc/tty?
In-Reply-To: <787b0d920607091257u52198c55sb8973a39bff3fcc8@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0607101601470.5071@yvahk01.tjqt.qr>
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com> 
 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com> 
 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com> 
 <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com> 
 <787b0d920607091226sb1db56dg9c0267f6ae8e2dc7@mail.gmail.com> 
 <20060709193133.GA32457@flint.arm.linux.org.uk>
 <787b0d920607091257u52198c55sb8973a39bff3fcc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Just do /proc/*/tty links and all will be good. This even
> handles the case of two different names for the same dev_t.
>
Is this for the controlling tty? Then it should be ctty.


Jan Engelhardt
-- 

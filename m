Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTLCWGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 17:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTLCWGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 17:06:44 -0500
Received: from smtp.terra.es ([213.4.129.129]:27976 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S261731AbTLCWGl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 17:06:41 -0500
Date: Wed, 3 Dec 2003 23:07:16 +0100
From: "grundig@teleline.es" <grundig@teleline.es>
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
Message-Id: <20031203230716.247fa67d.grundig@teleline.es>
In-Reply-To: <bqlhuv$jh2$1@gatekeeper.tmr.com>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com>
	<20031202180251.GB17045@work.bitmover.com>
	<bqlhuv$jh2$1@gatekeeper.tmr.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El 3 Dec 2003 20:44:15 GMT davidsen@tmr.com (bill davidsen) escribió:

> 
> Linus accepted it for 2.6, does it need to be blessed by the Pope, or what?

Linus accepted _many_ things in 2.6 ;)


> Now that is bullshit and you know it! This is not a pet feature, this
> is code which has has been stable for years. There just aren't any
> other candidates, all the other FS stuff went in with less testing and
> have fewer users now (JFS as example). This is also not code offered

Not only Fs's, the entire vm got replaced and the fact that was made
doesn't mean it was right.

AFAICT, Marcelo isn't taking any decision that would unstabilize the stable
tree. I'm happy with that. He isn't taking other things which are _far_
more importante for people, ALSA for example (drivers that you can just
disable. And it doesn't touch VFS code) and _nobody_ cares abouth that.

(Personally I don't think Marcelo would refuse XFS if it wouldn't touch
the VFS code. The fact that some people think Marcelo is refusing it because
he doesn't likes the code is stupid - he made clear that the problem
is the VFS related part)

Hopefully hch will review it, he will agree that it's
right, or he will find bugs that nobody has triggered with the xfs patches,
and xfs will be merged and all this fscking flame will stop

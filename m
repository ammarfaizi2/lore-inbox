Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTJJP5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbTJJP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:57:14 -0400
Received: from relay5.ftech.net ([195.200.0.100]:48515 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id S262986AbTJJP4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:56:07 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E25CA91@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'David S. Miller'" <davem@redhat.com>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: RE: [TRIVIAL] [PATCH] generic HDLC Cisco bugfix
Date: Fri, 10 Oct 2003 16:56:00 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this only for 2.6.x or does it also include 2.4.x and 2.2.x
I ask this because I will need to submit a patch for the farsync WAN drivers
soon which will need to be applied to all three kernels.

Regards

Kevin

-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com] 
Sent: 10 October 2003 07:44
To: Krzysztof Halasa
Cc: torvalds@osdl.org; linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] [PATCH] generic HDLC Cisco bugfix



Applied.

Please, Krzysztof, linux-kernel and Linus are not the appropriate place to
submit networking (device driver or otherwise) patches.

Therefore, in the future send it to netdev@oss.sgi.com and CC: either Jeff
Garzik or myself, thanks.

I'd also not classify this patch as trivial, it's not like a missing
semicolon or a comment typo, real thought needs to be applied to analyzing
whether your fix were correct or not.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

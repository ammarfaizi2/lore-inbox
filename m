Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266207AbUHBBJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUHBBJV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 21:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUHBBJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 21:09:21 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:19344 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S266207AbUHBBJS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 21:09:18 -0400
Date: Sun, 1 Aug 2004 20:09:19 -0500
From: Tommy Reynolds <Tommy.Reynolds@MegaCoder.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops in register_chrdev, what did I do?
Message-Id: <20040801200919.5da16bc7.Tommy.Reynolds@MegaCoder.com>
In-Reply-To: <yw1xwu0i1vcp.fsf@kth.se>
References: <yw1xwu0i1vcp.fsf@kth.se>
X-Mailer: Sylpheed version 0.9.12cvs1 (GTK+ 1.2.10; i686-redhat-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered Måns Rullgård <mru@kth.se>, spake thus:

> While experimenting a bit with a small kernel module, I got this
> oops.  Digging further, I found that /proc/devices had an entry saying
> 248 <NULL>
> which would indicate that I passed a NULL name to register_chrdev(),
> only I didn't.  I used a string constant, so I can't see what changed
> it to NULL along the way.
> 
> What am I missing here?

Enough information for us to help you.  Show us your code snippet,
please.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTIVVvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTIVVvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:51:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34574 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261178AbTIVVvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:51:14 -0400
Date: Mon, 22 Sep 2003 16:51:04 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiler warnings and syscall macros
Message-Id: <20030922165104.29176e94.reynolds@redhat.com>
In-Reply-To: <3F6F6B1B.9040609@nortelnetworks.com>
References: <3F6F6B1B.9040609@nortelnetworks.com>
Organization: Red Hat GLS
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered Chris Friesen <cfriesen@nortelnetworks.com>, spoke thus:

> Would it hurt anything if I put in an explicit cast, like this?
> 
> __sc_ret = (unsigned long) -1;

Why not do the obvious:

	__sc_ret = -1UL;

and use a proper constant?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTIUPiK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 11:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTIUPiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 11:38:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29970 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262434AbTIUPiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 11:38:08 -0400
Date: Sun, 21 Sep 2003 10:38:02 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: "sting sting" <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL MACRO definition (in 2.4.18-3) - newbie
Message-Id: <20030921103802.138e96fa.reynolds@redhat.com>
In-Reply-To: <Sea2-F317wbaj3ywtsI00006dd5@hotmail.com>
References: <Sea2-F317wbaj3ywtsI00006dd5@hotmail.com>
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

Uttered "sting sting" <zstingx@hotmail.com>, spoke thus:

> I want to know where EXPORT_SYMBOL macro is defined  (in 2.4.18-3 kernel).

It's optionally defined in module source code.

This symbol is used to tailor the symbol scoping rules implemented by
the module utilities.  A module is free to define this symbol before
importing the standard module #include<> files.  Use is voluntary
(2.4.x) but strongly recommended.

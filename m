Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272323AbTHIKqx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 06:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272324AbTHIKqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 06:46:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:33676 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272323AbTHIKqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 06:46:52 -0400
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Willy Tarreau <willy@w.ods.org>, jamie@shareable.org,
       albert@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       chip@pobox.com
In-Reply-To: <20030809015142.56190015.davem@redhat.com>
References: <1060087479.796.50.camel@cube>
	 <20030809002117.GB26375@mail.jlokier.co.uk>
	 <20030809081346.GC29616@alpha.home.local>
	 <20030809015142.56190015.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060425774.4933.73.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Aug 2003 11:42:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-08-09 at 09:51, David S. Miller wrote:
> I believe the C language allows for systems where the NULL pointer is
> not zero.

Its a fudge for some systems. However NULL == 0 is always true.

> I can't think of any reason why the NULL macro exists otherwise.

<OldFart>
NULL is really important in K&R C because you don't have prototypes and
sizeof(foo *) may not be the same as sizeof(int). This leads to very
nasty problems that people nowdays forget about.
</OldFart>



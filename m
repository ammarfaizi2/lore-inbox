Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTBJMYF>; Mon, 10 Feb 2003 07:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267725AbTBJMYF>; Mon, 10 Feb 2003 07:24:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19885
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264729AbTBJMYE>; Mon, 10 Feb 2003 07:24:04 -0500
Subject: Re: [BK PATCH] LSM changes for 2.5.59
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Crispin Cowan <crispin@wirex.com>
Cc: LA Walsh <law@tlinx.org>, "'Christoph Hellwig'" <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-security-module@wirex.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E471F21.4010803@wirex.com>
References: <001001c2d0b0$cf49b190$1403a8c0@sc.tlinx.org>
	 <3E471F21.4010803@wirex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044883918.418.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Feb 2003 13:31:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-10 at 03:40, Crispin Cowan wrote:
> Because Linus asked for access control support, not audit logging 
> support, it is not surprising that logging models don't fit so well.

The snare folks are moving bit by bit from their original hacks to
a clean audit hook model. That may give you the hooks you want for
auditing in 2.7. Thats seperate to the security stuff and you may
want one and not the other.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263066AbTCWOPY>; Sun, 23 Mar 2003 09:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263067AbTCWOPY>; Sun, 23 Mar 2003 09:15:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42914
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263066AbTCWOPY>; Sun, 23 Mar 2003 09:15:24 -0500
Subject: Re: [PATCH] fix powerbook media bay
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: paulus@samba.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <15997.17378.538276.91950@nanango.paulus.ozlabs.org>
References: <15997.17378.538276.91950@nanango.paulus.ozlabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048433932.10727.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 15:38:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 05:19, Paul Mackerras wrote:
> This patch fixes a couple of bugs and compile errors in the powerbook
> media bay driver.  It was getting initialized after the IDE subsystem,
> whereas it needs to be initialized before so that the IDE subsystem
> can see the CD-ROM drive in the bay.

IDE supports dynamic addition of interfaces so it should be possible
to make this work either way around.


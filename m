Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbTACBE7>; Thu, 2 Jan 2003 20:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267404AbTACBE7>; Thu, 2 Jan 2003 20:04:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25738
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267403AbTACBE6>; Thu, 2 Jan 2003 20:04:58 -0500
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Ogrisegg <tom@rhadamanthys.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lm@bitmover.com
In-Reply-To: <20030103004543.GA12399@window.dhis.org>
References: <20021230012937.GC5156@work.bitmover.com>
	<1041489421.3703.6.camel@rth.ninka.net>
	<20030102221210.GA7704@window.dhis.org>
	<20030102.151346.113640740.davem@redhat.com> 
	<20030103004543.GA12399@window.dhis.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Jan 2003 01:56:27 +0000
Message-Id: <1041558987.24809.114.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-03 at 00:45, Thomas Ogrisegg wrote:
> Unfortunately the linux-sendfile is not as good as the HP-UX
> one. Under HP-UX you can define a "struct iovec" header to
> be sent before the file is sent.

Thats a design decision. With TCP_CORK and sensible syscall performance
those kind of web specific hacks are not appropriate


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbTALP7s>; Sun, 12 Jan 2003 10:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTALP7s>; Sun, 12 Jan 2003 10:59:48 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8342
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267229AbTALP7r>; Sun, 12 Jan 2003 10:59:47 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030112092706.GN30025@kroah.com>
References: <20030110161012.GD2041@holomorphy.com>
	 <1042219147.31848.65.camel@irongate.swansea.linux.org.uk>
	 <20030112092706.GN30025@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042390527.15051.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 12 Jan 2003 16:55:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 09:27, Greg KH wrote:
> I've looked into this, and wow, it's not a simple fix :(
> 
> But this is really the first it's been mentioned, I can't see holding up
> 2.6 for this.  It's a 2.7 job at the earliest, unless someone wants to
> step up and do it right now...

2.5.x crashes erratically and randomly under high tty/pty load. At the 
moment I'm assuming this is the tty code. That means we can't decide not
to fix it since its already fatally broken.

Alan


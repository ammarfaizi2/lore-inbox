Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264030AbTE3XHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 19:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTE3XHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 19:07:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6111
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264030AbTE3XHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 19:07:40 -0400
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function
	declarations.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0305301535100.4421@bigblue.dev.mcafeelabs.com>
References: <20030530212013.GE3308@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.44.0305301431390.2671-100000@home.transmeta.com>
	 <20030530222630.GF3308@wohnheim.fh-wedel.de>
	 <Pine.LNX.4.55.0305301535100.4421@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054333383.27312.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 23:23:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-30 at 23:39, Davide Libenzi wrote:
> Talking about the code, there are still a bunch of files that uses spaces
> with tabsize=4. Shouldn't those be reformatted with real TABs ? An emacs
> lisp (indent+tabify) might do it pretty fast ...

indent -kr -i8 -bri0 -l255 

seems to do the job even faster. I did a pile of the scsi drivers when I
went over them. The big thing is not to mix indent with real changes.
Its always a temptation but its vital that there are no outstanding
changes and that a patch exists where you can test before and after
indent to verify that change didnt cause the problems


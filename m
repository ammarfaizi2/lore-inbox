Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTLEAJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTLEAJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:09:44 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:52096
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263760AbTLEAJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:09:41 -0500
Date: Thu, 4 Dec 2003 19:08:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Mike Fedyk <mfedyk@matchmail.com>, fuzzy77@free.fr,
       linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
In-Reply-To: <20031203201149.42f58e2a.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.58.0312041907500.27578@montezuma.fsmlabs.com>
References: <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
 <20031126233738.GD1566@mis-mike-wstn.matchmail.com> <3FC53A3B.50601@free.fr>
 <20031202160303.2af39da0.rddunlap@osdl.org> <20031203003106.GF4154@mis-mike-wstn.matchmail.com>
 <20031202162745.40c99509.rddunlap@osdl.org> <3FCDE506.7020302@free.fr>
 <Pine.LNX.4.58.0312031409410.27578@montezuma.fsmlabs.com> <3FCE877B.3010703@free.fr>
 <20031204013408.GE29119@mis-mike-wstn.matchmail.com>
 <20031203201149.42f58e2a.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Randy.Dunlap wrote:

> | > >Do you see any floppy disk activity at all? I'll see if i can come up with
> | > >something.
> | >
> | > Yes, there *is* floppy activity. The previous messages make it to the
> | > floppy (in that case, I experienced with
> | > Alt-Sysrq+S/Alt-Sysrq+U/Alt-Sysrq+D), but the oops doesn't...
>
> It seems possible that these commands (above) are flushing the kernel
> log buffer to disk (/var/log/messages e.g.), so that they don't need
> to be saved by kmsgdump.  Have you looked in the kernel message file
> for them?

In which case i'm slightly confused as to what's happening to the oops ;)
Dare i delve into kmsgdump?

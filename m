Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268026AbTAIWIf>; Thu, 9 Jan 2003 17:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268028AbTAIWIf>; Thu, 9 Jan 2003 17:08:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59278
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268026AbTAIWIe>; Thu, 9 Jan 2003 17:08:34 -0500
Subject: Re: [Linux-fbdev-devel] Re: rotation.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Sven Luther <luther@dpt-info.u-strasbg.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301091956140.5660-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301091956140.5660-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042153388.28469.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 23:03:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 19:59, James Simmons wrote:
> > > So, we also support fbcon for not left to righ locales ?
> > This looks like a high-level thing to me.
> > Ideally something like ansi escape sequences to switch between
> > left-to-right, right-to-left, and up-to-down advancing of
> > the cursor.  Then the same multilingual apps will work with
> > fbdev, xterm, and other terminals and emulators that
> > implement those operations.
> 
> Yeap. Such things are supported on the console level. ISO6429 support.

Note btw that the support ends rather abruptly on the console input side.
There is no support for 3 or 4 byte utf8 input sequences and the delete
key code in the kernel has no understanding of or support for UTF8
deletion behaviour


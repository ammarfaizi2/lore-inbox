Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbTAITSl>; Thu, 9 Jan 2003 14:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbTAITSl>; Thu, 9 Jan 2003 14:18:41 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15246
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266976AbTAITSl>; Thu, 9 Jan 2003 14:18:41 -0500
Subject: Re: MB without keyboard controller / USB-only keyboard ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301091916.h09JGI228106@devserv.devel.redhat.com>
References: <20030109114247.211f7072.skraw@ithnet.com>
	 <1042134121.27796.20.camel@irongate.swansea.linux.org.uk>
	 <20030109183952.6be142fe.skraw@ithnet.com>
	 <mailman.1042135501.3903.linux-kernel2news@redhat.com>
	 <200301091916.h09JGI228106@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042143195.27796.64.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 20:13:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 19:16, Pete Zaitcev wrote:
> I fail to see the point, Alan. Stephan's BIOS does exactly the
> right thing: it emulates BIOS INTs which allow to read buffered
> keystrokes, but it does not do SMM tricks to emulate port 0x60.
> This is great, now pc_keyb.d must do detection right. It must
> not loop endlessly if 0xff is returned from inb(). It's a bug.

Thats what I wanted to verify.


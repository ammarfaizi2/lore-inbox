Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTIIAyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTIIAyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:54:09 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:63363 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263827AbTIIAyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:54:08 -0400
Subject: Re: [2.4.23-pre3] Possible bug in fs/buffer.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Schwab <schwab@suse.de>
In-Reply-To: <200309081812.36916@bilbo.math.uni-mannheim.de>
References: <200309081715.09657@bilbo.math.uni-mannheim.de>
	 <je3cf7uw0f.fsf@sykes.suse.de>
	 <1063036721.21084.55.camel@dhcp23.swansea.linux.org.uk>
	 <200309081812.36916@bilbo.math.uni-mannheim.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063068776.28653.46.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 01:52:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 17:12, Rolf Eike Beer wrote:
> gcc didn't even find that. He complained about a line slightly above this one. 
> In limits.h there is no value equal to -1UL.

UINT_MAX in a standard C limits.h. Right now I dont think the kernel
defines it but  it could and ANSI C deals with this stuff.


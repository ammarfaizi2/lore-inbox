Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTIIAzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTIIAzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:55:08 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:64387 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263840AbTIIAzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:55:04 -0400
Subject: Re: [2.4.23-pre3] Possible bug in fs/buffer.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Schwab <schwab@suse.de>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <jellsztgf6.fsf@sykes.suse.de>
References: <200309081715.09657@bilbo.math.uni-mannheim.de>
	 <je3cf7uw0f.fsf@sykes.suse.de>
	 <1063036721.21084.55.camel@dhcp23.swansea.linux.org.uk>
	 <jellsztgf6.fsf@sykes.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063068835.28622.48.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Tue, 09 Sep 2003 01:53:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-08 at 17:04, Andreas Schwab wrote:
> > Its not 100% reliable either 8).
> 
> Could you please elaborate?  Casting -1 to an unsigned type is guaranteed
> to yield the maximum value for that type, at least since C89, but I think
> even K&R C did get it right.

My error - its ~0 that is unreliable.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263696AbTIHWOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTIHWOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:14:15 -0400
Received: from aneto.able.es ([212.97.163.22]:64663 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263696AbTIHWOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:14:11 -0400
Date: Tue, 9 Sep 2003 00:13:59 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andreas Schwab <schwab@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.23-pre3] Possible bug in fs/buffer.c
Message-ID: <20030908221359.GA2376@werewolf.able.es>
References: <200309081715.09657@bilbo.math.uni-mannheim.de> <je3cf7uw0f.fsf@sykes.suse.de> <1063036721.21084.55.camel@dhcp23.swansea.linux.org.uk> <jellsztgf6.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <jellsztgf6.fsf@sykes.suse.de>; from schwab@suse.de on Mon, Sep 08, 2003 at 18:04:45 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.08, Andreas Schwab wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > On Llu, 2003-09-08 at 16:42, Andreas Schwab wrote:
> >> It's neither ugly, nor bogus.  The only 100% reliable way to assign the
> >> maximum value to an unsigned integer is to use -1.
> >
> > Its not 100% reliable either 8).
> 
> Could you please elaborate?  Casting -1 to an unsigned type is guaranteed
> to yield the maximum value for that type, at least since C89, but I think
> even K&R C did get it right.
> 

Would not be much cleaner to do use ~0UL ?

-- 
J.A. Magallon <jamagallon@able.es>      \            Software is like sex:
werewolf.able.es                         \      It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))

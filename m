Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWJGNQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWJGNQz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 09:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbWJGNQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 09:16:55 -0400
Received: from accolon.hansenpartnership.com ([64.109.89.108]:9103 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S1751789AbWJGNQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 09:16:54 -0400
Subject: Re: Merge window closed: v2.6.19-rc1
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0610061932280.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	 <9a8748490610061547g6c62ee7dq37c139c1966ea8c5@mail.gmail.com>
	 <Pine.LNX.4.64.0610061932280.3952@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 08:16:51 -0500
Message-Id: <1160227011.3459.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 19:33 -0700, Linus Torvalds wrote:
> Gaah. That voyager timer handling is a bit confusing.
> 
> Maybe something like this would fix it?
> 
> Untested. Need James or the other alledged voyager-owner to actually test 
> or do somethign better..

There are other alleged voyager owners ... see, I keep telling you its a
popular architecture ...

I'll take a look ... I think I can probably eliminate the regs usage
from the VIC code as well.

James



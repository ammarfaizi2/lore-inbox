Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTEBVck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 17:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbTEBVck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 17:32:40 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:45240 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263176AbTEBVcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 17:32:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] alternative compat_ioctl table implementation
Date: Fri, 2 May 2003 23:42:04 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <200305021959.02726.arnd@arndb.de.suse.lists.linux.kernel> <p73r87h1aq6.fsf@oldwotan.suse.de>
In-Reply-To: <p73r87h1aq6.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305022342.05365.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 May 2003 20:09, Andi Kleen wrote:

> Rather ugly. In my experience all vmlinux.lds hacks are very fragile
> and they break when you just look at them in the wrong way. Also when
> something goes wrong they are a bitch to debug. And binutils is not
> exactly known for not introducing bugs with new releases.
Ok.

> Can't you work around that gcc 2.95 bug in some other way ?
Yes. I noticed now that only the x86_64 code (from which I copied) 
contains the assembly version that breaks on cross-compile
and the sparc64 version works fine.

	Arnd <><

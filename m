Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTEBR5c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbTEBR5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:57:32 -0400
Received: from ns.suse.de ([213.95.15.193]:3600 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263036AbTEBR5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:57:30 -0400
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] alternative compat_ioctl table implementation
References: <200305021959.02726.arnd@arndb.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2003 20:09:53 +0200
In-Reply-To: <200305021959.02726.arnd@arndb.de.suse.lists.linux.kernel>
Message-ID: <p73r87h1aq6.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> 
> Opinions?

Rather ugly. In my experience all vmlinux.lds hacks are very fragile
and they break when you just look at them in the wrong way. Also when
something goes wrong they are a bitch to debug. And binutils is not
exactly known for not introducing bugs with new releases.

Can't you work around that gcc 2.95 bug in some other way ? 

-Andi

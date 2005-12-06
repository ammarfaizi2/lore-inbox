Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932636AbVLFW1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbVLFW1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVLFW1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:27:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:61934 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932636AbVLFW1r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:27:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
Date: Tue, 6 Dec 2005 23:27:08 +0100
User-Agent: KMail/1.8.3
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       viro@ftp.linux.org.uk
References: <20051206035220.097737000@localhost> <1133905298.8027.13.camel@localhost> <17302.3696.364669.18755@cargo.ozlabs.ibm.com>
In-Reply-To: <17302.3696.364669.18755@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512062327.08448.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 06 Dezember 2005 23:19 schrieb Paul Mackerras:
> Having it in fs/ also means that it is more likely that people
> familiar with VFS internals will look through your code and comment on
> it.  I know that can be painful in the short term, but in the long
> term it will lead to better code.

Yes, that is an excellent point. How should we proceed to get the code
there?
Do you want to move the files around in your git tree or do you
prefer me to send a full set of patches again and kill the existing
copy? Obviously, I'd prefer the former, since it would mean less
work for me with the same result.

	Arnd <><

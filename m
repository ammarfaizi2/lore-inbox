Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVDERuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVDERuS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVDERtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:49:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14035 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261852AbVDER05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:26:57 -0400
Date: Tue, 5 Apr 2005 13:26:44 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Crash during boot for 2.6.12-rc2.
In-Reply-To: <Xine.LNX.4.44.0504050605170.10569-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0504051325520.12266-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, James Morris wrote:

> > Surprise, surprise, it works OK here.
> > 
> > What compiler version?
> 
> gcc -v
> Using built-in specs.
> Target: i386-redhat-linux
> Configured with: ../configure --prefix=/usr --mandir=/usr/share/man 
> --infodir=/usr/share/info --enable-shared --enable-threads=posix 
> --enable-checking=release --with-system-zlib --enable-__cxa_atexit 
> --disable-libunwind-exceptions --enable-languages=c,c++,objc,java,f95,ada 
> --enable-java-awt=gtk --host=i386-redhat-linux
> Thread model: posix
> gcc version 4.0.0 20050329 (Red Hat 4.0.0-0.38)
> 
> 
> I'll try a fresh compile later.

Looks like it was a miscompile, newly compiled (without ccache, too) 
kernel works fine.


- James
-- 
James Morris
<jmorris@redhat.com>



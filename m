Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWHYIoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWHYIoz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWHYIoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:44:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:14581 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932225AbWHYIoy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:44:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 11/17] BLOCK: Move common FS-specific ioctls to linux/fs.h [try #2]
Date: Fri, 25 Aug 2006 10:44:44 +0200
User-Agent: KMail/1.9.1
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200608250023.20903.arnd@arndb.de> <20060824213318.21323.12558.stgit@warthog.cambridge.redhat.com> <1925.1156495117@warthog.cambridge.redhat.com>
In-Reply-To: <1925.1156495117@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608251044.44901.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 10:38, David Howells wrote:
> 
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> >       case FS_IOC_GETFLAGS32:
> >       case FS_IOC_GETFLAGS64:
> 
> That'll get you a "duplicate case statement" warning on a 32-bit arch.
> 

No, I defined them with u32 and u64 arguments, respectively, so the
numbers are distinct on 32 bit.

	Arnd <><

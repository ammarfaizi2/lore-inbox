Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSEVWoW>; Wed, 22 May 2002 18:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315425AbSEVWoV>; Wed, 22 May 2002 18:44:21 -0400
Received: from web14208.mail.yahoo.com ([216.136.173.72]:18954 "HELO
	web14208.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315337AbSEVWoU>; Wed, 22 May 2002 18:44:20 -0400
Message-ID: <20020522224420.37850.qmail@web14208.mail.yahoo.com>
Date: Wed, 22 May 2002 15:44:20 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: 2.5 ext2fs as a module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On attempting to compile 2.5 from Linus bk tree, it compiles fine, but depmod
gives me unresolved symbols in ext2.o.  It seems as if ext2 needs
write_mapping_buffers

My guess would be to add an EXPORT_SYMBOL(write_mapping_buffers) somewhere in
the code.  WOuld this be correct?

TIA
Erik

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262474AbSJOMmt>; Tue, 15 Oct 2002 08:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262490AbSJOMmt>; Tue, 15 Oct 2002 08:42:49 -0400
Received: from mnh-1-02.mv.com ([207.22.10.34]:17924 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262474AbSJOMms>;
	Tue, 15 Oct 2002 08:42:48 -0400
Message-Id: <200210151352.IAA02057@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Oleg Drokin <green@namesys.com>, Mike Anderson <andmike@us.ibm.com>
cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.42-1 
In-Reply-To: Your message of "Tue, 15 Oct 2002 10:42:10 +0400."
             <20021015104210.A1335@namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Oct 2002 08:52:17 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

green@namesys.com said:
> For some reason I now need this patch to make bk-current to compile 

That patch is against stock 2.5.42, so I don't make any guarantees about
bk-current.

However the __i386__ thing should be taken care of by Makefile-i386 doing
	CFLAGS += -U__i386__

I might have messed up the patch, I'll check and fix it if so.

				Jeff


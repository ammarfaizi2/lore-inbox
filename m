Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbSJPBor>; Tue, 15 Oct 2002 21:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSJPBor>; Tue, 15 Oct 2002 21:44:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29355 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264689AbSJPBor>;
	Tue, 15 Oct 2002 21:44:47 -0400
Date: Tue, 15 Oct 2002 18:43:24 -0700 (PDT)
Message-Id: <20021015.184324.04643044.davem@redhat.com>
To: ak@muc.de
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Add extended attributes to ext2/3
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <m3y98zp4c7.fsf@averell.firstfloor.org>
References: <200210160211.39284.agruen@suse.de>
	<3DACB86A.829ECF3C@digeo.com>
	<m3y98zp4c7.fsf@averell.firstfloor.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@muc.de>
   Date: 16 Oct 2002 03:20:08 +0200
   
   But I wonder why this weird ifdef. Is there any reason why the other
   architectures are not supported ? 

Especially weird considering the fact that ppc32's do_div() doesn't
even operate on 64-bit values :-)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVCKXYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVCKXYP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 18:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVCKXVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:21:16 -0500
Received: from ozlabs.org ([203.10.76.45]:35748 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261846AbVCKXIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:08:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16946.9510.285579.725037@cargo.ozlabs.ibm.com>
Date: Sat, 12 Mar 2005 10:09:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dave Jones <davej@redhat.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <20050311222614.GH4185@redhat.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<20050311021248.GA20697@redhat.com>
	<16944.65532.632559.277927@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org>
	<87vf7xg72s.fsf@devron.myhome.or.jp>
	<20050311222614.GH4185@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:

> I'm fascinated that not a single person picked up on this problem
> whilst the agp code sat in -mm. Even if DRI isn't enabled,
> every box out there with AGP that uses the generic routines
> (which is a majority), should have barfed loudly when it hit
> this check during boot.  Does no-one read dmesg output any more ?

That loop would only get executed when you enable AGP, which I think
would generally only happen when starting X with DRI enabled.

Paul.

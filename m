Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUBPKLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 05:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbUBPKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 05:11:16 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:2738 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265477AbUBPKLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 05:11:15 -0500
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop
	device?) on 2.6.*)
From: Christophe Saout <christophe@saout.de>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c0prf8$m3c$1@abraham.cs.berkeley.edu>
References: <402A4B52.1080800@centrum.cz>
	 <20040216014433.GA5430@leto.cs.pocnet.net>
	 <20040215175337.5d7a06c9.akpm@osdl.org>
	 <1076900296.5601.41.camel@leto.cs.pocnet.net>
	 <c0prf8$m3c$1@abraham.cs.berkeley.edu>
Content-Type: text/plain
Message-Id: <1076926270.5228.17.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 11:11:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb David Wagner um 08:28:

> Probably I'm misunderstanding something, but: Do you really mean that
> you are using ECB mode?  How is that secure?  (Everyone knows why ECB
> mode should almost never be used, right?)

Yes, it is how it sounds. It's only used if explicitly specified
assuming the user knows what he's doing. It's mainly for backwards
compatibility because cryptoloop can do the same (but it isn't used by
default either).



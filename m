Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbUBPKPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 05:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUBPKPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 05:15:35 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:12978 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265468AbUBPKPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 05:15:34 -0500
Subject: Re: dm-crypt using kthread
From: Christophe Saout <christophe@saout.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0402160510360.26082@alpha.polcom.net>
References: <402A4B52.1080800@centrum.cz>
	 <1076866470.20140.13.camel@leto.cs.pocnet.net>
	 <20040215180226.A8426@infradead.org>
	 <1076870572.20140.16.camel@leto.cs.pocnet.net>
	 <20040215185331.A8719@infradead.org>
	 <1076873760.21477.8.camel@leto.cs.pocnet.net>
	 <20040215194633.A8948@infradead.org>
	 <20040216014433.GA5430@leto.cs.pocnet.net>
	 <20040215175337.5d7a06c9.akpm@osdl.org>
	 <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net>
	 <1076900606.5601.47.camel@leto.cs.pocnet.net>
	 <Pine.LNX.4.58.0402160409190.26082@alpha.polcom.net>
	 <4030416E.9070805@pobox.com>
	 <Pine.LNX.4.58.0402160510360.26082@alpha.polcom.net>
Content-Type: text/plain
Message-Id: <1076926521.5228.20.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 11:15:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Grzegorz Kulewski um 05:14:

> Yes, I understand that (at least I think so...). But Knopix (and probably 
> other distros) use 2.4 with compressing loop patch, and I think somebody 
> at Gentoo is trying to port that patch to 2.6 for Gentoo's LiveCD... So it 
> was done somehow... (I do not know how, however.)

compressed loop is read-only. The filesystem is created on a normal
device, then encrypted into a big file with a static index.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUBPDDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbUBPDDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:03:47 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:61093 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265316AbUBPDDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:03:45 -0500
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop
	device?) on 2.6.*)
From: Christophe Saout <christophe@saout.de>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net>
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
Content-Type: text/plain
Message-Id: <1076900606.5601.47.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 04:03:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 16.02.2004 schrieb Grzegorz Kulewski um 03:07:

> > Is there more documentation that this?  I'd imagine a lot of crypto-loop
> > users wouldn't have a clue how to get started on dm-crypt, especially if
> > they have not used device mapper before.
> > 
> > And how do they migrate existing encrypted filesytems?
> 
> And is the format considered "stable"?
> (= if I will create fs on it, will I have problems with future kernels?)

Yes. The cryptoloop compatible format will stay this way. The format
(basically the cipher used and the iv generation mode) can be specified.

I posted a small description some time ago:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105967481007242&w=2

The -cbc was renamed to -plain in order to make more iv generation
methods possible which of course also use the CBC mode.



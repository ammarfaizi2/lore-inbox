Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUCAWvt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUCAWvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:51:48 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:8197 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261473AbUCAWvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:51:46 -0500
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or
	loop	device?) on 2.6.*)
From: Christophe Saout <christophe@saout.de>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2004.03.01.22.18.59.135752@smurf.noris.de>
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
	 <pan.2004.03.01.22.18.59.135752@smurf.noris.de>
Content-Type: text/plain
Message-Id: <1078181496.3415.0.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 23:51:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 01.03.2004 schrieb Matthias Urlichs um 23:18:

> > I posted a small description some time ago:
> 
> Thanks.
> 
> How do I specify the encryption algorithm's bit size? AES can use 128,
> 196, or 256 bits. Gues who didn't use the default (128) when creating the
> file system on his keychain's USB thing  :-/

Simply specify a key that is 192 bits long (24 bytes or 48 hex digits).



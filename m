Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUCAXY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 18:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUCAXY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 18:24:59 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:58841 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261481AbUCAXY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 18:24:58 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Tue, 2 Mar 2004 00:22:48 +0100
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop	device?) on 2.6.*)
Message-ID: <20040301232248.GA9040@kiste>
References: <1076870572.20140.16.camel@leto.cs.pocnet.net> <20040215185331.A8719@infradead.org> <1076873760.21477.8.camel@leto.cs.pocnet.net> <20040215194633.A8948@infradead.org> <20040216014433.GA5430@leto.cs.pocnet.net> <20040215175337.5d7a06c9.akpm@osdl.org> <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net> <1076900606.5601.47.camel@leto.cs.pocnet.net> <pan.2004.03.01.22.18.59.135752@smurf.noris.de> <1078181496.3415.0.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078181496.3415.0.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christophe Saout:
> Matthias Urlichs:
> > How do I specify the encryption algorithm's bit size? AES can use 128,
> > 196, or 256 bits. Gues who didn't use the default (128) when creating the
> > file system on his keychain's USB thing  :-/
> 
> Simply specify a key that is 192 bits long (24 bytes or 48 hex digits).
> 
In other words, that's the job of the front-end program which reads the
key from <wherever>.

If/when updating the documentation, please add a pointer to a frontend
program that can emulate losetup <encryption> <bits> -- assuming one 
has been written..?

-- 
Matthias Urlichs

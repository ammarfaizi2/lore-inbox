Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUIJRas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUIJRas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUIJR3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:29:11 -0400
Received: from scrye.com ([216.17.180.1]:55772 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S267620AbUIJR2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:28:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Sep 2004 11:27:59 -0600
From: Kevin Fenzi <kevin-linux-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: FYI: my current bigdiff
X-Draft-From: ("scrye.linux.kernel" 66560)
References: <20040909134421.GA12204@elf.ucw.cz>
	<20040910041320.DF700E7504@voldemort.scrye.com>
	<20040910094448.GD11281@atrey.karlin.mff.cuni.cz>
Message-Id: <20040910172803.0588C8E012@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Pavel" == Pavel Machek <pavel@suse.cz> writes:

>> kernel: Freeing memory...
>> ^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H
>> \^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-
>> ^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^
>> H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^Hdone
>> (44436 pages freed)
>> 
>> (BTW, that looks pretty nasty in the logs, even though it's very
>> nice to watch)

Pavel> Hmm, not sure how to solve this. It does not look *that* bad in
Pavel> the logs, I believe.

Yeah, a minor issue. 

>> - - The display is much nicer. Congrats.
>> 
>> - - Speed does seem to be nicer. It's taking me 40 seconds to do a
>> complete suspend/resume cycle.
>> 
>> - - Should PREEMPT and/or HIMEM work with this version? I can test
>> them if support has been added/fixed/tweaked for them.

Pavel> Both should work.

ok. I have built a 2.6.9-rc1-mm4+bigdiff with preempt and himem
enabled, and everything looks working so far. :) 

>> I have only done a few cycles, but it looks nice and stable. I
>> would suggest you break it into smaller patches and get it
>> applied. Being applied to the main tree would be nice.

Pavel> I'm working on that, believe me.  Pavel 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBQeQj3imCezTjY0ERAqXbAJ9hvPiMY4rzKH7coixPcLhNt6zYLgCdFNK2
kHOZED1Wt0S/uDdok5FbtHw=
=8chA
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUIJWKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUIJWKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUIJWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:10:45 -0400
Received: from open.hands.com ([195.224.53.39]:27789 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267957AbUIJWKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:10:43 -0400
Date: Fri, 10 Sep 2004 23:21:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: CMedia CM9739 - sneaked in via some cheap via motherboards
Message-ID: <20040910222155.GA19158@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay.

some of the cheapest and yet not nastiest motherboards are beginning
to become available, in the UK for £12 (KM400 chipsets) www.ebuyer.com.

some of these contain CMedia CM9739 sound chips which are _supposed_ to
be AC97.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0302.3/1283.html

... except the present (2.6.7) kernel code doesn't work.

it _almost_ works - it just doesn't recognise the PCM slider.
alsamixer can't set PCM
kmix and kamix don't even _show_ PCM.

which ain't much cop, really, cos no PCM means "no sound matey".

so!

with these chipsets likely to become more prevalent (trust me
on this) and CMedia having an OSS AC97 driver [which according to above
by alan differs from the linux one]...

... anyone want to have a go at helping me get this to work,
at proxy?

if so, what sort of information should i provide?

i can get lspci's, listings of /proc/asound contents, i'm even
reasonably incompetent (viz. "not enough fear") at hacking
bits of kernel code.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


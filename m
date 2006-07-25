Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWGYVUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWGYVUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWGYVUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:20:07 -0400
Received: from mail.gmx.de ([213.165.64.21]:53164 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751597AbWGYVUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:20:05 -0400
X-Authenticated: #428038
Date: Tue, 25 Jul 2006 23:20:01 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: David Lang <dlang@digitalinsight.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: automated test? (was Re: Linux 2.6.17.7)
Message-ID: <20060725212001.GA5493@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	David Lang <dlang@digitalinsight.com>,
	Andrew de Quincey <adq_dvb@lidskialf.net>,
	Arnaud Patard <apatard@mandriva.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org
References: <20060725034247.GA5837@kroah.com> <m33bcqdn5y.fsf@anduin.mandriva.com> <200607251123.40549.adq_dvb@lidskialf.net> <Pine.LNX.4.63.0607250945400.9159@qynat.qvtvafvgr.pbz> <1153846619.8932.36.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153846619.8932.36.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, Arjan van de Ven wrote:

> well you can do such a thing withing statistical bounds; however... if
> the patch already is in -git (as is -stable policy normally).. it should
> have been found there already...

The sad facts I learned from Debian bug #212762 (not kernel related) that
culminated in CVE-2005-2335 (remote root exploit against older
fetchmail) and from various qmail bugs Guninski discovered:

- a bug need not necessarily be found soon after introduction

- a bug report may not convey the hint "look at this NOW, the shit
  already hit the fan"
  (sorry, I meant to write: look NOW, it's urgent and important)

- an automated test to catch non-trivial mistakes is non-trivial in
  itself, and - what I've seen with another project I was involved with,
  and more often than I found amusing - is that the test itself can be
  buggy causing bogus results.

That doesn't mean I object to automated tests, but "it should have been
found by now" (because the source is open, someone could have tested it,
whatever) just doesn't work.

-- 
Matthias Andree

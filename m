Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWAXX2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWAXX2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 18:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWAXX2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 18:28:05 -0500
Received: from mail.gmx.net ([213.165.64.21]:35559 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750835AbWAXX2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 18:28:02 -0500
X-Authenticated: #428038
Date: Wed, 25 Jan 2006 00:27:57 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "Theodore Ts'o" <tytso@mit.edu>, Arjan van de Ven <arjan@infradead.org>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060124232757.GB9613@merlin.emma.line.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Arjan van de Ven <arjan@infradead.org>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	linux-kernel@vger.kernel.org
References: <20060123180106.GA4879@merlin.emma.line.org> <1138039993.2977.62.camel@laptopd505.fenrus.org> <20060123185549.GA15985@merlin.emma.line.org> <43D530CC.nailC4Y11KE7A@burner> <20060123203010.GB1820@merlin.emma.line.org> <1138092761.2977.32.camel@laptopd505.fenrus.org> <43D5EEA2.nailCE7111GPO@burner> <1138094141.2977.34.camel@laptopd505.fenrus.org> <20060124212843.GA15543@thunk.org> <20060124232629.GA9613@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124232629.GA9613@merlin.emma.line.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree schrieb am 2006-01-25:

> What if the limit were RLIM_INFINITY for root processes instead of
> hacking mlockall() and the resource checks?

OK, reading Edgar's hint, the answer is "It's a bad idea."

-- 
Matthias Andree

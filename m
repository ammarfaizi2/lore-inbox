Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWF2M4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWF2M4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWF2M4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:56:08 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:51603 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750718AbWF2M4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:56:06 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Luck, Tony" <tony.luck@intel.com>,
       John Daiker <jdaiker@osdl.org>, John Hawkes <hawkes@sgi.com>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	<yq04py4i9p7.fsf@jaguar.mkp.net>
	<1151578928.23785.0.camel@localhost.localdomain>
	<44A3AFFB.2000203@sgi.com>
	<1151578513.3122.22.camel@laptopd505.fenrus.org>
From: Jes Sorensen <jes@sgi.com>
Date: 29 Jun 2006 08:56:05 -0400
In-Reply-To: <1151578513.3122.22.camel@laptopd505.fenrus.org>
Message-ID: <yq0veqkgly2.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Arjan" == Arjan van de Ven <arjan@infradead.org> writes:

Arjan> read what Alan said: the HZ exposed to userspace is
Arjan> *constant*. For example, the i386 user visible HZ is 100, even
Arjan> if the kernel runs at a HZ of 250 or 1000.... Just when a HZ
Arjan> value gets exposed to userspace, it's transformed into a HZ=100
Arjan> based value.

Arjan> And that's not a distribution thing, that's the kernel.org
Arjan> kernel honoring the stable-userspace-interface contract, and
Arjan> common sense..

See what you mean, thanks.

Jes

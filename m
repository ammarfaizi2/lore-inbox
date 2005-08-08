Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVHHRxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVHHRxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVHHRxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:53:01 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:24502 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932165AbVHHRxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:53:00 -0400
Message-ID: <42F79BFE.4010707@zabbo.net>
Date: Mon, 08 Aug 2005 10:53:02 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
Cc: jgarzik@pobox.com, greg@kroah.com, kristen.c.accardi@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 6700/6702PXH quirk
References: <20050805225712.GD3782@kroah.com>	<20050806033455.GA23679@havoc.gtf.org>	<42F7998D.8030606@zabbo.net> <20050808.104530.85410060.davem@davemloft.net>
In-Reply-To: <20050808.104530.85410060.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You can hide the "complexity" of the second line behind
> macros.  And this is what is done in most places.

oh, I agree.  My only point is that if the *only* argument against
bitfields is that they're inefficient (insert vague hand-waving) then
people will happily decide to live with that inefficiency.  I'm all for
macros that are both efficient *and* abstract away the risk of getting
open-coding wrong.

- z

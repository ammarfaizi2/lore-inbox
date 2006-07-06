Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWGFQwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWGFQwD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWGFQwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:52:03 -0400
Received: from colin.muc.de ([193.149.48.1]:38673 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932420AbWGFQwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:52:00 -0400
Date: 6 Jul 2006 18:51:59 +0200
Date: Thu, 6 Jul 2006 18:51:59 +0200
From: Andi Kleen <ak@muc.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
Message-ID: <20060706165159.GB66955@muc.de>
References: <20060703184836.GA46236@muc.de> <1151962114.16528.18.camel@localhost.localdomain> <20060704092358.GA13805@muc.de> <1152007787.28597.20.camel@localhost.localdomain> <20060704113441.GA26023@muc.de> <1152137302.6533.28.camel@localhost.localdomain> <20060705220425.GB83806@muc.de> <m1odw32rep.fsf@ebiederm.dsl.xmission.com> <20060706130153.GA66955@muc.de> <m18xn621i6.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18xn621i6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With EDAC on my next boot I get positive confirmation that I either
> pulled the DIMM that the error happened on, or I pulled a different
> DIMM.

How? You simulate a new error and let EDAC resolve it?

> 
> Mapping the hardware addresses to the motherboard silk screen label
> before hand is unnecessary and just ensures that you pull out the DIMM
> you are trying for the first time.  Making it an optimization for
> people who do that a lot.

Sorry I didn't parse that. 

> To the best of my knowledge mcelog even with the --dmi option cannot
> give me that.

You mean identify if a given DIMM is still plugged in? You can get that 
information from dmidecode

-Andi

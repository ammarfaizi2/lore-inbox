Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTESLJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbTESLJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:09:08 -0400
Received: from holomorphy.com ([66.224.33.161]:26853 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262386AbTESLJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:09:07 -0400
Date: Mon, 19 May 2003 04:21:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Christoph Hellwig <hch@infradead.org>, KML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519112156.GF8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Schlemmer <azarah@gentoo.org>,
	Christoph Hellwig <hch@infradead.org>,
	KML <linux-kernel@vger.kernel.org>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519105152.GD8978@holomorphy.com> <1053342842.9152.90.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053342842.9152.90.camel@workshop.saharact.lan>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 12:51, William Lee Irwin III wrote:
>> IIRC you're supposed to use some sort of sanitized copy, not the things
>> directly. IMHO the current state of affairs sucks as there is no
>> standard set of ABI headers, but grabbing them right out of the kernel
>> is definitely not the way to go.

On Mon, May 19, 2003 at 01:14:02PM +0200, Martin Schlemmer wrote:
> Ok, anybody know of an effort to get this done ?
> Also, what about odd things that are more kernel dependant
> like imon support in fam for example ?  The imon.h will not
> be in the 'sanitized copy' ....

It probably has to be hand-crafted for cases like the above.

I'm unaware of anyone actually doing anything about this.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTDUUn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTDUUn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:43:27 -0400
Received: from holomorphy.com ([66.224.33.161]:42645 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261999AbTDUUnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:43:25 -0400
Date: Mon, 21 Apr 2003 13:53:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jt@hpl.hp.com
Cc: irda-users@lists.sourceforge.net, Muli Ben-Yehuda <mulix@mulix.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 6 memory leaks
Message-ID: <20030421205355.GD8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, jt@hpl.hp.com,
	irda-users@lists.sourceforge.net, Muli Ben-Yehuda <mulix@mulix.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030421202728.GA25358@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030421202728.GA25358@bougret.hpl.hp.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote :
>> I'm in terror. ASSERT()? return NULL in a macro argument?
>> Any chance of cleaning that up a bit while you're at it?

On Mon, Apr 21, 2003 at 01:27:28PM -0700, Jean Tourrilhes wrote:
> 	Rather than fixing imaginary non-existing bugs, I prefer to
> spend my time fixing real bugs that byte real users. This construct is
> perfectly sound and valid, and it needs to be done in this way, the
> only issue is that someone should rename "ASSERT" into "IRDA_ASSERT".

The construct is a Lovecraftian horror. I've already lost my lunch once
over extremely disgusting code today, and I don't care to intentionally
read or run IRDA code ever again.


-- wli

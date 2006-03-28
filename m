Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWC1HXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWC1HXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWC1HXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:23:46 -0500
Received: from smop.co.uk ([81.5.177.201]:50925 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S932244AbWC1HXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:23:45 -0500
Date: Tue, 28 Mar 2006 08:23:40 +0100
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback
Message-ID: <20060328072340.GB29429@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060326211514.GA19287@wyvern.smop.co.uk> <20060327172356.7d4923d2.akpm@osdl.org> <20060328070220.GA29429@smop.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328070220.GA29429@smop.co.uk>
User-Agent: Mutt/1.5.11+cvs20060126
From: adrian <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.688,
	required 5, autolearn=not spam, AWL -0.09, BAYES_00 -2.60,
	NO_RELAYS -0.00)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 08:02:20 +0100 (+0100), adrian wrote:
> I suppose that leads to a new question - what's the easiest way to
> start to break down origin.patch and do you know of any likely

I suppose starting with 2.6.15-rc5-mm3 would be a good start (I'll
double check 2.6.15-rc5 + origin patch from 2.6.15-rc5-mm3 is okay and
then bisect the remainder).

Adrian

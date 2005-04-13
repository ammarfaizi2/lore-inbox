Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVDMH0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVDMH0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 03:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVDMH0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 03:26:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62924 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262276AbVDMH0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 03:26:49 -0400
Date: Wed, 13 Apr 2005 08:26:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Kilau, Scott" <Scott_Kilau@digi.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050413072646.GA32634@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ricky Beam <jfbeam@bluetronic.net>,
	"Kilau, Scott" <Scott_Kilau@digi.com>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
	Wen Xiong <wendyx@us.ibm.com>
References: <20050412153245.GA11521@infradead.org> <Pine.GSO.4.33.0504122258510.1894-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0504122258510.1894-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 11:27:44PM -0400, Ricky Beam wrote:
> As an outside observer, I think he's given you plenty of reason to not
> include this "hack".  You, however, appear to only want to make a mess.

Why do you consider it a mess, and what reason did you see?

The jsm driver is an effort where people like Wen Xiong, Al Viro and me
put in a lot of effort to make the piece of crap the digi driver was into
something almost sane.  Now we should limit it to a tiny subset of the
supported hardware just because digi is full of crack?

> This is entirely the attitude the denouncers of open source live for.  It
> shows the complete lake of respect for the wishes of the maintainer(s).

While Scott wrote most of the original code that ended up in the jsm driver
he's certainly not the maintainer in any sense.

> they "give" you their code. (If it's already GPL'd, there's nothing legally
> stopping the code from being included in the first place, so why must they
> ask for and/or ok inclusion?  Answer: good will within the community which
> you are now pissing all over.)

But the original code isn't technically suitable.

> Am I the only one with his eyes open here?  When I read the first reply from
> Scott, I was thinking, "why not just make it a config option?  What's the
> big f***ing deal?"  Make it a config option with help text pointing people
> to the "better" driver with improved features and support for that board.
> Or something as simple as "don't enable this if you're going to use this
> other dirver."

Because a config option is totally pointless.  If Scott wants someone to
use his driver he can that person to simply load that driver, there's
absolutely no reason for us to cripple our drivers because some vendor
has out of tree drivers.  We don't remove support for card from tg3 just
because Broadcom would prefer us to use their bcm5700 driver, or remove
support for cards from the 3c59x driver just because 3com has a driver of
their own for a few of those cards.



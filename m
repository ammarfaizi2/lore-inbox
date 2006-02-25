Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbWBYIll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWBYIll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 03:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWBYIll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 03:41:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31711 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932599AbWBYIlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 03:41:40 -0500
Date: Sat, 25 Feb 2006 08:41:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
       okir@suse.de
Subject: Re: [Announce] Intel PRO/Wireless 3945ABG Network Connection
Message-ID: <20060225084139.GB22109@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Ketrenos <jketreno@linux.intel.com>,
	NetDev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	okir@suse.de
References: <43FF88E6.6020603@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FF88E6.6020603@linux.intel.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 04:29:58PM -0600, James Ketrenos wrote:
> As a result of this change, some of the capabilities currently required
> to be provided on the host include enforcement of regulatory limits for
> the radio transmitter (radio calibration, transmit power, valid
> channels, 802.11h, etc.) In order to meet the requirements of all
> geographies into which our adapters ship (over 100 countries) we have
> placed the regulatory enforcement logic into a user space daemon that
> we provide as a binary under the same license agreement as the
> microcode.  We provide that binary pre-compiled as both a 32-bit and

the regualatory problems are not true.  they are completely focused on
the users.  Someone who wants to change it can always do it, may it be
by binary patching.  I don't know of a single country that forbids
implementing those bits in source code shipped, and in those countries
we alredy couldn't distribute the kernel.

A binary daemon is completely unacceptable and unless you fix that there
is zero chance the driver could get into mainline.  I'd also like to
urge the distributors to not put this crap in to weaken our free drivers
future.  Intel, please stop this madness and play by the rules.


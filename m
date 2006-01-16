Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWAPTHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWAPTHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWAPTHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:07:14 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:44562 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751161AbWAPTHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:07:12 -0500
Date: Mon, 16 Jan 2006 14:06:33 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Samuel Ortiz <samuel.ortiz@nokia.com>
Cc: ext Stuffed Crust <pizza@shaftnet.org>, Jeff Garzik <jgarzik@pobox.com>,
       Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060116190629.GB5529@tuxdriver.com>
Mail-Followup-To: Samuel Ortiz <samuel.ortiz@nokia.com>,
	ext Stuffed Crust <pizza@shaftnet.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org> <Pine.LNX.4.58.0601152038540.19953@irie> <20060116170951.GA8596@shaftnet.org> <Pine.LNX.4.58.0601162020260.17348@irie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601162020260.17348@irie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 08:51:31PM +0200, Samuel Ortiz wrote:
> On Mon, 16 Jan 2006, ext Stuffed Crust wrote:
> 
> > On Sun, Jan 15, 2006 at 09:05:33PM +0200, Samuel Ortiz wrote:
> > > Regarding 802.11d and regulatory domains, the stack should also be able to
> > > stick to one regulatory domain if asked so by userspace, whatever the APs
> > > around tell us.
> >
> > ...and in doing so, violate the local regulatory constraints.  :)
> The other option is to conform to whatever the AP you associate with
> advertises. In fact, this is how it should be done according to 802.11d.
> Unfortunately, this doesn't ensure local regulatory constraints compliance
> unless you expect each and every APs to do the Right Thing ;-)

If regulators come down on someone, it seems like common sense
that they would be more lenient on mobile stations complying with a
misconfigured AP than they would be with a mobile station ignoring a
properly configured AP?  I know expecting common sense from government
regulators is optimistic, but still... :-)

Of course when we are the AP, the ability to adjust these parameters
could be very important.  No?

John
-- 
John W. Linville
linville@tuxdriver.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWAPSxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWAPSxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWAPSxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:53:36 -0500
Received: from mgw-ext04.nokia.com ([131.228.20.96]:33419 "EHLO
	mgw-ext04.nokia.com") by vger.kernel.org with ESMTP
	id S1751131AbWAPSxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:53:35 -0500
Date: Mon, 16 Jan 2006 20:51:31 +0200 (EET)
From: Samuel Ortiz <samuel.ortiz@nokia.com>
X-X-Sender: samuel@irie
Reply-To: samuel.ortiz@nokia.com
To: ext Stuffed Crust <pizza@shaftnet.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Johannes Berg <johannes@sipsolutions.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
In-Reply-To: <20060116170951.GA8596@shaftnet.org>
Message-ID: <Pine.LNX.4.58.0601162020260.17348@irie>
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com>
 <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com>
 <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org>
 <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org>
 <Pine.LNX.4.58.0601152038540.19953@irie> <20060116170951.GA8596@shaftnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 16 Jan 2006 18:51:32.0959 (UTC) FILETIME=[DE76E6F0:01C61ACD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2006, ext Stuffed Crust wrote:

> On Sun, Jan 15, 2006 at 09:05:33PM +0200, Samuel Ortiz wrote:
> > Regarding 802.11d and regulatory domains, the stack should also be able to
> > stick to one regulatory domain if asked so by userspace, whatever the APs
> > around tell us.
>
> ...and in doing so, violate the local regulatory constraints.  :)
The other option is to conform to whatever the AP you associate with
advertises. In fact, this is how it should be done according to 802.11d.
Unfortunately, this doesn't ensure local regulatory constraints compliance
unless you expect each and every APs to do the Right Thing ;-)


> Allowing
> the user to change the regulatory domain at will.. is a rather fuzzy
> legal area, to say the least.
IMHO, strictly sticking to 802.11d is also somehow legally fuzzy as you're
as legal as the network you're joining.

Cheers,
Samuel.
